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
  private let service = SuperSimpleNetworkEngine()
  private var searchController: GMSAutocompleteViewController!
  var isForecastsAreInitiallyLoaded:Bool {
    cities.count == forecasts.count
  }
  //MARK: - Array of City objects for initial tableView full-filling
  private var cities: [City] = ConstantsHelper.cities
  
  //MARK: - Array of recieved and parsed YandexForecast objects with observer-like functionality
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
    button.addTarget(self, action: #selector(goToSearchController), for: .touchUpInside)
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchController = getPreparedSearchViewControler()
    if !isForecastsAreInitiallyLoaded {
      updateForecast(forLastElement: false)
    }
  }
  
  override func viewSafeAreaInsetsDidChange() {
 setupUI()
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
//    setupUI()
    
  }
  
//  private func setupTableView() {
//    tableView = UITableView(frame: view.safeAreaLayoutGuide.layoutFrame)
//    tableView.frame.size.height = view.frame.height - searchButton.frame.height - view.safeAreaInsets.bottom
//    tableView.separatorStyle = .singleLine
//    tableView.frame.origin.y -= view.safeAreaInsets.top
//    tableView.delegate = self
//    tableView.dataSource = self
//    tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "mainCell")
//  }
//
  func updateTableView(for reason: UpdatingReason ) {
    switch reason {
      case .initialUpdate:
        var indexPath = [IndexPath]()
        print(forecasts.count)
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
  
  //MARK: - UI related things
  private func setupUI() {
    view.backgroundColor = UIColor.UIColorFromHex(hex: "#315760ff")
    [searchButton, tableView].forEach {
      view.addSubview($0)
    }
  }
  
  private func getPreparedSearchViewControler() -> GMSAutocompleteViewController {
    let searchVC = GMSAutocompleteViewController()
    searchVC.delegate = self
    let filter = GMSAutocompleteFilter()
    filter.type = .city
    searchVC.autocompleteFilter = filter
    return searchVC
  }
}

//MARK: - Updating tableView according recieved forecasts
extension MainViewController {
  
  private func updateForecast(forLastElement: Bool) {
    let group = DispatchGroup()
    if !forLastElement {
      for city in cities {
        group.enter()
        print("Вызываю сервис в - \(Thread.current)")
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
    let pageVC = PageViewController(with: forecasts, startIndex: indexPath.row)
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
  }
  
  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    print(error.localizedDescription)
    dismiss(animated: true)
  }
  
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true)
  }
}

//MARK:- Navigation
extension MainViewController {
  @objc func goToSearchController() {
    present(searchController, animated: true)
  }
}

extension MainViewController {
  private func runInMainQueue(block: @escaping () -> ()) {
    DispatchQueue.main.async {
      block()
    }
  }
}
