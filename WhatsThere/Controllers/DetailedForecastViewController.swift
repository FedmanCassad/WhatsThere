//
//  DetailedForecastViewController.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 08.03.2021.
//

import UIKit
import SVGKit

protocol Pageable {
  var index: Int { get set }
}

final class DetailedForecastViewController: UIViewController, Pageable {
  private var forecast: YandexForecast
  private weak var iconsCache: IconsStorage?
  var index: Int
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.backgroundColor = UIColor.UIColorFromHex(hex: "#315760ff")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.allowsSelection = false
    tableView.clipsToBounds = true
    tableView.register(DetailedViewControllerCell.self, forCellReuseIdentifier: "detailsCell")
    return tableView
  }()
  
  private lazy var detailCardView: DetailedCard = {
    let detailCard = DetailedCard()
    detailCard.configure(with: forecast)
    detailCard.clipsToBounds = true
    detailCard.layer.cornerRadius = 15
    detailCard.translatesAutoresizingMaskIntoConstraints = false
    return detailCard
  }()
  
  private lazy var sputnikImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "sputnik")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  init(with forecast: YandexForecast, pageIndex: Int, iconsCache: IconsStorage) {
    self.forecast = forecast
    self.index = pageIndex
    self.iconsCache = iconsCache
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    setupUI()
  }
  
  private func setupUI() {
    view.backgroundColor = UIColor.UIColorFromHex(hex: "#315760ff")
    view.addSubview(detailCardView)
    view.addSubview(tableView)
    view.addSubview(sputnikImageView)
    NSLayoutConstraint.activate(commonConstraints)
  }
  
  private lazy var commonConstraints: [NSLayoutConstraint] = [
    detailCardView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
    detailCardView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.25),
    detailCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    detailCardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
    tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
    tableView.topAnchor.constraint(equalTo: detailCardView.bottomAnchor),
    tableView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.35),
    sputnikImageView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
    sputnikImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    sputnikImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    sputnikImageView.widthAnchor.constraint(equalTo: sputnikImageView.heightAnchor),
  ]
}

//MARK:- UITableView events handling
extension DetailedForecastViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    forecast.nextDaysForecasts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell") as? DetailedViewControllerCell else {
      return UITableViewCell()
    }
    cell.configure(with: forecast.nextDaysForecasts[indexPath.row], cache: iconsCache)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    45
  }
}
