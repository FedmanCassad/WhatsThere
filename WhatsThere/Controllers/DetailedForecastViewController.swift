//
//  DetailedForecastViewController.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 08.03.2021.
//

import UIKit
import SVGKit

final class DetailedForecastViewController: UIViewController {
  var forecast: YandexForecast
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "commonCell")
    return tableView
  }()
  
  lazy var detailCardView: DetailedCard = {
    let detailCard = DetailedCard()
    detailCard.configure(with: forecast)
    detailCard.clipsToBounds = true
    detailCard.layer.cornerRadius = 15
    detailCard.translatesAutoresizingMaskIntoConstraints = false
    return detailCard
  }()
  
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
    setupUI()
    var date = forecast.nextDaysForecasts[2].date
    date.convertToLocalWeekday()
    print(date)
  }
  
  private func setupUI() {
    view.backgroundColor = UIColor.UIColorFromHex(hex: "#315760ff")
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
    tableView.heightAnchor.constraint(equalToConstant: 180)
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
    cell.backgroundColor = UIColor.UIColorFromHex(hex: "#315760ff")
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    30
  }
  
  
}
