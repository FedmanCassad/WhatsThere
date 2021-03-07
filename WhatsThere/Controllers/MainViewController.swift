//
//  ViewController.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 06.03.2021.
//

import UIKit
import GooglePlaces

final class MainViewController: UIViewController, GMSAutocompleteViewControllerDelegate {
  var tableView: UITableView!
  let service = SuperSimpleNetworkEngine()
  let defaultCities: [City] = [
   City(cityName: "Североморск", latitude: 69.06617190, longitude: 33.43116440),
    City(cityName: "Мурманск", latitude: 68.96519350, longitude: 33.07340370),
    City(cityName: "Москва", latitude: 55.76159020, longitude: 37.60946000),
    City(cityName: "Санкт-Петербург", latitude: 59.93425620, longitude: 30.33512280),
    City(cityName: "Пекин", latitude: 39.90274840, longitude: 116.40081940),
    City(cityName: "Минск", latitude: 53.89619600, longitude: 27.55030930),
    City(cityName: "Сочи", latitude: 43.58499970, longitude: 39.71878350),
    City(cityName: "Краснодар", latitude: 45.04010190, longitude: 38.95558500),
    City(cityName: "Нью-Йорк", latitude: 40.71298220, longitude: -74.00720500),
    City(cityName: "Хельсинки", latitude: 60.17380240, longitude: 24.93848890)

  ]

  lazy var searchButton: UIButton = {
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
    return button
  }()
  
  override var prefersStatusBarHidden: Bool {
    return false
  }
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    
  }
  
  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    print(error.localizedDescription)
  }
  
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
   dismiss(animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView = UITableView()

    service.getForecast(from: defaultCities[0]) {result in
      switch result {
        case .failure(let error):
          assertionFailure(error.localizedDescription)
        case .success(let forecast):
          print(forecast)
      }
      
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    setupTableView()
    setupUI()
    
    
  }

  private func setupUI() {
    view.backgroundColor = .white
    
    let searchVC = SearchCitiesController()
    searchVC.delegate = self
    navigationController?.setNavigationBarHidden(true, animated: true)
    view.addSubview(searchButton)
    
    
    tableView.frame.size.height -= searchButton.frame.height
    tableView.backgroundColor = .white
    view.addSubview(tableView)
//    navigationController?.present(searchVC, animated: true)
//    self.present(searchVC, animated: true, completion: nil)
  }
  
  private func setupTableView() {
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "commonCell")
  }
}



extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "commonCell") else { return UITableViewCell() }
    return cell
  }
  
  
}
