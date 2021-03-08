//
//  PageViewControllerForDetails.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 08.03.2021.
//

import UIKit

final class PageViewController: UIViewController {
  var dataSource: [YandexForecast]
  private var currentIndex: Int
  private var pageController: UIPageViewController!
  
  init(with forecasts: [YandexForecast], startIndex: Int) {
    dataSource = forecasts
    currentIndex = startIndex
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    setupPageController()
  }
  
  private func setupPageController() {
    pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    pageController.dataSource = self
    pageController.delegate = self
    pageController.view.backgroundColor = .clear
    let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: nil)
    navigationItem.rightBarButtonItem = rightBarButtonItem
    pageController.view.frame = CGRect(x: 0,
                                       y: 0,
                                       width: view.frame.width,
                                       height: view.frame.height - view.safeAreaInsets.bottom)
    pageController.setViewControllers([DetailedForecastViewController(with: dataSource[currentIndex], and: currentIndex)], direction: .forward, animated: true)
    addChild(pageController)
    view.addSubview(pageController.view)
    pageController.didMove(toParent: self)
  }
}

// Here is the magic exists. Long time spent fixing this. I have an idea how to fix lagging with paging but...
//MARK: - PageViewController events handling
extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let currentVC = viewController as? DetailedForecastViewController else {
      return nil
    }
    currentIndex = currentVC.index
    
    if currentIndex == 0 {
      return nil
    }
    currentIndex -= 1
    return DetailedForecastViewController(with: dataSource[currentIndex], and: currentIndex)
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let currentVC = viewController as? DetailedForecastViewController else {
      return nil
    }
    currentIndex = currentVC.index
    if currentIndex >= dataSource.count - 1 {
      return nil
    }
    currentIndex += 1
    return DetailedForecastViewController(with: dataSource[currentIndex], and: currentIndex)
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    dataSource.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return currentIndex
  }
}
