//
//  ViewController.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 06.03.2021.
//

import UIKit
import GooglePlaces


enum UpdatingReason {
  case initialUpdate, cityAdded
}

final class MainViewController: UIViewController {
  private var isTableViewInitiallyUpdated: Bool = false
  private let service: WeatherFetcher = SuperSimpleNetworkEngine()
  var isForecastsAreInitiallyLoaded:Bool {
    cities.count == forecasts.count
  }
  
  private var iconsLocalCache: IconsStorage?
  
  //MARK: - Array of City objects for initial tableView full-filling
  private var cities: [City] = ConstantsHelper.cities
  
  //MARK: - Array of recieved and parsed YandexForecast objects
  private var forecasts: [YandexForecast] = [YandexForecast]()
  
  //MARK: - Lazy UIs
  private lazy var searchButton: UIButton = {
    let button = UIButton()
    button.setTitle("Search", for: .normal)
    button.sizeToFit()
    button.backgroundColor = .white
    button.layer.borderWidth = 2
    button.setTitleColor(.black, for: .normal)
    button.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
    button.layer.cornerRadius  = button.frame.height / 2
    button.frame.size.width = view.bounds.width * 0.8
    button.frame.origin.y = view.frame.maxY - view.safeAreaInsets.bottom - button.frame.height
    button.center.x = view.center.x
    button.addTarget(self, action: #selector(showSearchControllerModally), for: .touchUpInside)
    return button
  }()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: view.safeAreaLayoutGuide.layoutFrame)
    tableView.frame.size.height = view.frame.height - searchButton.frame.height - view.safeAreaInsets.bottom
    tableView.separatorStyle = .singleLine
    tableView.frame.origin.y -= view.safeAreaInsets.top
    tableView.backgroundColor = UIColor.UIColorFromHex(hex: "#315760ff")
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "mainCell")
    return tableView
  }()
  
  //MARK: - Решил использовать контроллер от гугла, который дергает сервис Google Places, так как геокодер от Apple не умеет в предиктивный поиск, а гугл и красиво ищет и предоставляет нужные нам данные о координатах.
  private var searchController: GMSAutocompleteViewController?
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    if !isForecastsAreInitiallyLoaded {
      updateForecast(forLastElement: false)
    }
   searchController = getPreparedSearchController()
  }
  
  override func viewSafeAreaInsetsDidChange() {
    setupUI()
  }
  
  private func setupUI() {
    view.backgroundColor = UIColor.UIColorFromHex(hex: "#315760ff")
    [searchButton, tableView].forEach {
      view.addSubview($0)
    }
  }
  
  private func getPreparedSearchController() -> GMSAutocompleteViewController {
    let searchVC = GMSAutocompleteViewController()
    let filter = GMSAutocompleteFilter()
    filter.type = .city
    searchVC.delegate = self
    searchVC.autocompleteFilter = filter
    return searchVC
  }
  
  //MARK:- Updating array of forecasts
  // Функция обновления массива прогнозов погоды
  // forLastElement: флаг в зависимости от которого мы запрашиваем у сетевого сервиса либо весь массив прогнозов на базе координат городов из массива Cities, либо для последнего города из массива городов  координатами. Сетевые запросы исполняются последовательно, чтобы результаты отображались в том же порядке что и в массиве cities.
  private func updateForecast(forLastElement: Bool) {
    let group = DispatchGroup()
    if !forLastElement {
      for city in cities {
        group.enter()
        service.getForecast(from: city) {result in
          switch result {
            case .failure(let error):
              assertionFailure(error.localizedDescription)
            case .success(let forecast):
              group.notify(queue: .main) {
                self.forecasts.append(forecast)
              }
          }
          group.leave()
        }
        group.wait()
      }
      group.notify(queue: .main) {
        self.updateTableView(for: .initialUpdate)
        self.iconsLocalCache = IconsCache(fetchIconsFrom: self.forecasts)
      }
    } else {
      guard let city = cities.last else {return}
      service.getForecast(from: city) {[weak self] result in
        guard let self = self else {return}
        switch result {
          case .failure(let error):
            assertionFailure(error.localizedDescription)
          case .success(let forecast):
            group.notify(queue: .main) {
              self.forecasts.append(forecast)
              self.updateTableView(for: .cityAdded)
            }
        }
      }
    }
  }
  
  //MARK: - Tableview update with animations
  private func updateTableView(for reason: UpdatingReason ) {
    switch reason {
      case .initialUpdate:
        var indexPath = [IndexPath]()
        for i in 0..<self.forecasts.count {
          indexPath.append(IndexPath(row: i, section: 0))
        }
        tableView.performBatchUpdates {
          tableView.insertRows(at: indexPath, with: .fade)
        }
      case .cityAdded:
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: forecasts.endIndex - 1, section: 0)], with: .fade)
        tableView.endUpdates()
        tableView.scrollToRow(at: IndexPath(row: forecasts.endIndex - 1, section: 0), at: .bottom, animated: true)
    }
  }
  
  @objc private func showSearchControllerModally() {
    present(searchController!, animated: true)
  }
}

//MARK: - Handling UITableView events
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    forecasts.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    90
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell") as? MainTableViewCell else { return UITableViewCell() }
    cell.configureCell(with: forecasts[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let pageVC = PageViewController(with: forecasts, startIndex: indexPath.row, iconsCache: iconsLocalCache!)
    present(pageVC, animated: true)
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let actions = UIContextualAction(style: .destructive, title: "Удалить") {_, _, isPerformed in
      self.cities.remove(at: indexPath.row)
      self.forecasts.remove(at: indexPath.row)
      self.tableView.deleteRows(at: [indexPath], with: .middle)
      isPerformed(true)
    }
    let swipeActionConfiguration = UISwipeActionsConfiguration(actions: [actions])
    return swipeActionConfiguration
  }
}

//MARK:- Handling events from GMSAutocompleteViewController
extension MainViewController: GMSAutocompleteViewControllerDelegate {
  
  
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    let cityToAdd = City(cityName: place.name ?? "Error getting cityName",
                         latitude: place.coordinate.latitude,
                         longitude: place.coordinate.longitude)
    cities.append(cityToAdd)
    dismiss(animated: true)
    updateForecast(forLastElement: true)
    searchController = getPreparedSearchController()
    
  }
  
  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    print(error.localizedDescription)
    dismiss(animated: true)
  }
  
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true)
  }
}

