//
//  DetailedForecastViewController.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 08.03.2021.
//

import UIKit
import SVGKit

final class DetailedForecastViewController: UIViewController {
  var forecast: YandexForecast {
    willSet {
      detailCardView.configure(with: forecast)
    }
  }
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "commonCell")
    return tableView
  }()
  
  let detailCardView = DetailedCard()
  
  override var prefersStatusBarHidden: Bool {
    return false
  }
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
  init(with forecast: YandexForecast) {
    self.forecast = forecast
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    detailCardView.translatesAutoresizingMaskIntoConstraints = false
    detailCardView.clipsToBounds = true
    detailCardView.layer.cornerRadius = 15
    view.addSubview(detailCardView)
    view.addSubview(tableView)
    NSLayoutConstraint.activate(commonConstraints)
    
  }
  
  lazy var commonConstraints: [NSLayoutConstraint] = [
    detailCardView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
    detailCardView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.25),
    detailCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    detailCardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
    tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
    tableView.topAnchor.constraint(equalTo: detailCardView.bottomAnchor),
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
  ]

}

extension DetailedForecastViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    forecast.nextDaysForecasts.count - 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "commonCell") else {
      return UITableViewCell()
    }
    cell.backgroundColor = .blue
    return cell
  }
  
  
}
