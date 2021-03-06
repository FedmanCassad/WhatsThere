//
//  ViewController.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 06.03.2021.
//

import UIKit
import GooglePlaces
final class MainViewController: UIViewController, GMSAutocompleteViewControllerDelegate {
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    print(place.name)
  }
  
  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    print(error.localizedDescription)
  }
  
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    return
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }

  private func setupUI() {
    view.backgroundColor = .white
    let searchVC = SearchCitiesController()
    searchVC.delegate = self
    self.present(searchVC, animated: true, completion: nil)
  }
  

}

