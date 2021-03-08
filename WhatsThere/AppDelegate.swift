//
//  AppDelegate.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 06.03.2021.
//

import UIKit
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//    let mainVC = MainViewController()
    GMSPlacesClient.provideAPIKey("AIzaSyDKubrAhenx__A0Uol4_22tvG6CKhLm55c")
    window = UIWindow(frame: UIScreen.main.bounds)
    let animationVC = StartAnimationViewController()
//    let navigationController = UINavigationController(rootViewController: mainVC)
    window?.rootViewController = animationVC
    window?.makeKeyAndVisible()
    return true
  }




}

