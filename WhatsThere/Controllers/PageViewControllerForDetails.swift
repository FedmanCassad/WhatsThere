//
//  PageViewControllerForDetails.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 08.03.2021.
//

import UIKit

final class PageViewController: UIPageViewController {
  var pages: [DetailedForecastViewController]
  private var currentIndex: Int
  
  init(with forecasts: [YandexForecast], startIndex: Int, iconsCache: IconsStorage ) {
    pages = [DetailedForecastViewController]()
    for (index, forecast) in forecasts.enumerated() {
      self.pages.append(DetailedForecastViewController(with: forecast, pageIndex: index, iconsCache: iconsCache))
    }
    self.currentIndex = startIndex
    super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setViewControllers([pages[currentIndex]], direction: .forward, animated: true)
    delegate = self
    dataSource = self
  }
}

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
    return pages[currentIndex]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let currentVC = viewController as? DetailedForecastViewController else {
      return nil
    }
    currentIndex = currentVC.index
    if currentIndex >= pages.count - 1 {
      return nil
    }
    currentIndex += 1
    return pages[currentIndex]
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    pages.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return currentIndex
  }
}
