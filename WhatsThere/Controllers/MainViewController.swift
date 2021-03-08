//
//  ViewController.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 06.03.2021.
//

import UIKit
import GooglePlaces

final class MainViewController: UIViewController {
  private var isTableViewInitiallyUpdated: Bool = false
  private let service = SuperSimpleNetworkEngine()
  private var tableView: UITableView!
  private var isForecastIsLoaded: Bool  {
    cities.count == forecasts.count
  }
  
  //MARK: - Array of City objects for initial tableView fullfilling
  private var cities: [City] = ConstantsHelper.cities {
    didSet {
      isTableViewInitiallyUpdated = true
      updateForecast(forLastElement: true)
    }
  }
  
  //MARK: - Array of recieved and parsed YandexForecast objects with observer-like functionality
 private var forecasts: [YandexForecast] = [YandexForecast]()
  {
    willSet {
      // Замысел следующий: определяем по флагам: если первый запуск, заполняем полностью таблицу основываясь на да
      if newValue.count == cities.count && !isTableViewInitiallyUpdated {
        DispatchQueue.main.async {[weak self] in
          self?.tableView.performBatchUpdates {
            var indexPath = [IndexPath]()
            for i in 0..<newValue.count {
              indexPath.append(IndexPath(row: i, section: 0))
            }
            self?.tableView.insertRows(at: indexPath, with: .fade)
          }
        }
      }
      else if newValue.count == cities.count && isTableViewInitiallyUpdated {
        DispatchQueue.main.async {[weak self] in
          self?.tableView.beginUpdates()
          self?.tableView.insertRows(at: [IndexPath(row: newValue.count - 1, section: 0)], with: .fade)
          self?.tableView.endUpdates()
        }
      }
    }
  }
  
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
  
  override var prefersStatusBarHidden: Bool {
    return false
  }
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if !isForecastIsLoaded {
      updateForecast(forLastElement: false)
    }
    setupTableView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupUI()
  }
  
  //MARK: - UI realated things
  private func setupUI() {
    view.backgroundColor = UIColor.UIColorFromHex(hex: "#315760ff")
    navigationController?.setNavigationBarHidden(true, animated: true)
    view.addSubview(searchButton)
    tableView.frame.size.height = view.frame.height - searchButton.frame.height - view.safeAreaInsets.bottom
    view.addSubview(tableView)
    tableView.backgroundColor = UIColor.UIColorFromHex(hex: "315760ff")
  }
  
  private func getPreparedSearchViewControler() -> SearchCitiesController {
    let searchVC = SearchCitiesController()
    searchVC.delegate = self
    let filter = GMSAutocompleteFilter()
    filter.type = .city
    searchVC.autocompleteFilter = filter
    return searchVC
  }
  
  private func setupTableView() {
    tableView = UITableView(frame: view.safeAreaLayoutGuide.layoutFrame)
    tableView.separatorStyle = .singleLine
    tableView.frame.origin.y -= view.safeAreaInsets.top
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "mainCell")
  }
}

//MARK: - Updating tableView according recieved forecasts
extension MainViewController {
  private func updateForecast(forLastElement: Bool) {
    if !forLastElement {
      for city in cities {
        service.getForecast(from: city) {[weak self] result in
          guard let self = self else {return}
          switch result {
            case .failure(let error):
              assertionFailure(error.localizedDescription)
            case .success(let forecast):
              self.forecasts.append(forecast)
          }
        }
      }
    } else {
      guard let city = cities.last else {return}
      service.getForecast(from: city) {[weak self] result in
        guard let self = self else {return}
        switch result {
          case .failure(let error):
            assertionFailure(error.localizedDescription)
          case .success(let forecast):
            self.forecasts.append(forecast)
            self.runInMainQueue {
              self.tableView.scrollToRow(at: IndexPath(row: self.forecasts.endIndex - 1, section: 0), at: .bottom, animated: true)
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
    navigationController?.present(pageVC, animated: true)
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
    navigationController?.present(getPreparedSearchViewControler(), animated: true)
  }
}

extension MainViewController {
  private func runInMainQueue(block: @escaping () -> ()) {
    DispatchQueue.main.async {
      block()
    }
  }
}
