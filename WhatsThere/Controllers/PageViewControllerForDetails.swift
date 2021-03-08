//
//  PageViewControllerForDetails.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 08.03.2021.
//

import UIKit

final class PageViewController: UIViewController {
  let dataSource: [YandexForecast]
  var currentIndex: Int
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
    pageController.setViewControllers([DetailedForecastViewController(with: dataSource[currentIndex])], direction: .forward, animated: true)
    addChild(pageController)
    view.addSubview(pageController.view)
    
    pageController.didMove(toParent: self)
  }
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard currentIndex != 0 else {
      print("Для предыдущего вернули nil")
      return nil
    }
    print("Текущий индекс \(currentIndex) расчитывая предыдущий")
    currentIndex -= 1
    print("Текущий индекс \(currentIndex) рассчитывая предыдущий")
    
   return DetailedForecastViewController(with: dataSource[currentIndex])
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    if currentIndex >= dataSource.count - 1 {
      print("Для следующего вернули nil")
      return nil
    }
    print("Текущий индекс \(currentIndex) расчитывая следующий")
   currentIndex += 1
    print("Текущий индекс \(currentIndex) рассчитывая следующий")
   return DetailedForecastViewController(with: dataSource[currentIndex])
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    dataSource.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return currentIndex
  }
}
