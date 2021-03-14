//
//  LaunchScreenAnimations.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 14.03.2021.
//

/*
 Эту анимацию в качестве помощи сделал мой брат. Спасибо ему!
 */
import UIKit

final class LaunchScreenAnimation: UIViewController {
  
  let nextViewControllerToShow: UIViewController
  
  //MARK:- Lazy initializing views
  private lazy var viewLS: UIView = {
    let viewLS = UIView()
    viewLS.frame = view.bounds
    viewLS.backgroundColor = UIColor(red: 0.19, green: 0.34, blue: 0.38, alpha: 1.00)
    return viewLS
  }()
  
  private lazy var earthImageView: UIImageView = {
    let earth = UIImage(named: "earth")
    let earthImageView:UIImageView = UIImageView()
    earthImageView.contentMode = UIView.ContentMode.scaleAspectFit
    earthImageView.frame = CGRect(
      x: 0,
      y: viewLS.frame.size.height / 2,
      width: viewLS.frame.size.width * 2,
      height: viewLS.frame.size.height
    )
    earthImageView.image = earth
    return earthImageView
  }()
  
  private lazy var sunImageView: UIImageView = {
    let sun = UIImage(named: "sun")
    let sunImageView:UIImageView = UIImageView()
    sunImageView.contentMode = UIView.ContentMode.scaleAspectFit
    sunImageView.frame = CGRect(
      x:  -viewLS.frame.size.width / 2,
      y: -viewLS.frame.size.height / 2,
      width: viewLS.frame.size.width,
      height: viewLS.frame.size.height
    )
    sunImageView.image = sun
    return sunImageView
  }()
  
  private lazy var moonImageView: UIImageView = {
    let moon = UIImage(named: "moon")
    let moonImageView:UIImageView = UIImageView()
    moonImageView.contentMode = UIView.ContentMode.scaleAspectFit
    moonImageView.frame = CGRect(
      x:  viewLS.frame.size.width / 1.5,
      y: viewLS.frame.size.width / 3,
      width: viewLS.frame.size.width / 5,
      height: viewLS.frame.size.width / 5
    )
    moonImageView.image = moon
    return moonImageView
  }()
  
  private lazy var sputnikImageView: UIImageView = {
    let sputnikImageView: UIImageView = UIImageView()
    let sputnikImage = UIImage(named: "sputnik")
    sputnikImageView.contentMode = UIView.ContentMode.scaleAspectFit
    sputnikImageView.frame = CGRect(
      x:  viewLS.frame.size.width / 2 - viewLS.frame.size.width / 2.4 / 2,
      y: viewLS.frame.size.height / 2 - viewLS.frame.size.height / 7 ,
      width: viewLS.frame.size.width / 2.4,
      height: viewLS.frame.size.height / 8.3
    )
    sputnikImageView.setTransformRotation(toDegrees: -13)
    sputnikImageView.image = sputnikImage
    return sputnikImageView
  }()
  
  private lazy var kakImageView: UIImageView =  {
    let kakImageView = UIImageView()
    let kak = UIImage(named: "kak")
    kakImageView.contentMode = UIView.ContentMode.scaleAspectFit
    kakImageView.frame = CGRect(
      x: sputnikImageView.center.x - viewLS.frame.size.width / 3.45 - 40,
      y: sputnikImageView.center.y - viewLS.frame.size.height / 16 - 20,
      width: viewLS.frame.size.width / 3.45,
      height: viewLS.frame.size.height / 16
    )
    kakImageView.center.x -= self.view.bounds.width
    kakImageView.image = kak
    return kakImageView
  }()
  
  private lazy var tamImageView: UIImageView =  {
    let tamImageView = UIImageView()
    let tam = UIImage(named: "tam")
    tamImageView.contentMode = UIView.ContentMode.scaleAspectFit
    tamImageView.frame = CGRect(
      x: sputnikImageView.center.x + 40,
      y: sputnikImageView.center.y + kakImageView.frame.size.height / 1.32 - 20,
      width: kakImageView.frame.size.width,
      height: kakImageView.frame.size.height / 1.32
    )
    tamImageView.center.x += self.view.bounds.width
    tamImageView.image = tam
    return tamImageView
  }()
  
  private lazy var waveImageView: UIImageView = {
    let waveImageView = UIImageView()
    let wave = UIImage(named: "wawe")
    waveImageView.contentMode = UIView.ContentMode.scaleAspectFit
    waveImageView.frame = CGRect(
      x: (sputnikImageView.center.x - viewLS.frame.size.width / 2.4 * 1.238 / 2) + 0.15 * (sputnikImageView.center.x - viewLS.frame.size.width / 2.4 * 1.238 / 2) ,
      y: sputnikImageView.center.y + viewLS.frame.size.height / 8.3 / 1.5,
      width: viewLS.frame.size.width / 2.4 * 1.238,
      height: viewLS.frame.size.height / 8.3
    )
    waveImageView.image = wave
    let overlayView = waveImageView
    overlayView.layer.compositingFilter = "overlayBlendMode"
    waveImageView.alpha = 0
    return waveImageView
  }()
  
  private lazy var weatherImageView1: UIImageView = {
    let weatherImageView1 = UIImageView()
    let weatherIcon1 = UIImage(systemName: "cloud.drizzle.fill")
    weatherImageView1.contentMode = UIView.ContentMode.scaleAspectFit
    weatherImageView1.frame = CGRect(
      x: earthImageView.frame.size.height / 8,
      y: earthImageView.frame.size.height / 3,
      width: viewLS.frame.size.width / 6.27,
      height: 80
    )
    weatherImageView1.image = weatherIcon1
    weatherImageView1.tintColor = .white
    weatherImageView1.alpha = 0
    return weatherImageView1
  }()
  
  private lazy var weatherImageView2: UIImageView =  {
    let weatherImageView2 = UIImageView()
    let weatherIcon2 = UIImage(systemName: "cloud.sun.fill")
    weatherImageView2.contentMode = UIView.ContentMode.scaleAspectFit
    weatherImageView2.frame = CGRect(
      x: earthImageView.frame.size.height / 4.7,
      y: earthImageView.frame.size.height / 5,
      width: viewLS.frame.size.width / 6.27,
      height: 80
    )
    weatherImageView2.image = weatherIcon2
    weatherImageView2.tintColor = .white
    weatherImageView2.alpha = 0
    return weatherImageView2
  }()
  
  private lazy var weatherImageView3: UIImageView =  {
    let weatherImageView3 = UIImageView()
    let weatherIcon3 = UIImage(systemName: "sun.max.fill")
    weatherImageView3.contentMode = UIView.ContentMode.scaleAspectFit
    weatherImageView3.frame = CGRect(
      x: earthImageView.frame.size.height / 3,
      y: earthImageView.frame.size.height / 7,
      width: viewLS.frame.size.width / 6.27,
      height: 80
    )
    weatherImageView3.image = weatherIcon3
    weatherImageView3.tintColor = .white
    weatherImageView3.alpha = 0
    return weatherImageView3
  }()
  
  private lazy var firstTemperatureLabel: UILabel = {
    let label1 = UILabel()
    label1.textAlignment = .center
    label1.text = "+13"
    label1.font = .boldSystemFont(ofSize: 25)
    label1.backgroundColor = .init(white: 1, alpha: 0.5)
    label1.translatesAutoresizingMaskIntoConstraints = false
    label1.alpha = 0
    return label1
  }()
  
  private lazy var secondTemperatureLabel: UILabel = {
    let label2 = UILabel()
    label2.textAlignment = .center
    label2.text = "+17"
    label2.font = .boldSystemFont(ofSize: 25)
    label2.backgroundColor = .init(white: 1, alpha: 0.5)
    label2.translatesAutoresizingMaskIntoConstraints = false
    label2.alpha = 0
    return label2
  }()
  
  private lazy var thirdTemperatureLabel: UILabel = {
    let label3 = UILabel()
    label3.textAlignment = .center
    label3.text = "+21"
    label3.font = .boldSystemFont(ofSize: 25)
    label3.backgroundColor = .init(white: 1, alpha: 0.5)
    label3.translatesAutoresizingMaskIntoConstraints = false
    label3.alpha = 0
    return label3
  }()
  
  init(nextViewController: UIViewController) {
    self.nextViewControllerToShow = nextViewController
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK:- Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviews()
    setupAutoLayout()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    performAnimations()
  }
  
  private func addSubviews() {
    viewLS.addSubview(earthImageView)
    viewLS.addSubview(sunImageView)
    viewLS.addSubview(moonImageView)
    viewLS.addSubview(sputnikImageView)
    viewLS.addSubview(kakImageView)
    viewLS.addSubview(tamImageView)
    viewLS.addSubview(waveImageView)
    earthImageView.addSubview(weatherImageView1)
    earthImageView.addSubview(firstTemperatureLabel)
    earthImageView.addSubview(weatherImageView2)
    earthImageView.addSubview(secondTemperatureLabel)
    earthImageView.addSubview(weatherImageView3)
    earthImageView.addSubview(thirdTemperatureLabel)
    self.view = viewLS
  }
  
  private func setupAutoLayout() {
    NSLayoutConstraint.activate (
      [
        firstTemperatureLabel.centerXAnchor.constraint(equalTo: weatherImageView1.centerXAnchor),
        firstTemperatureLabel.widthAnchor.constraint(equalTo: weatherImageView1.widthAnchor),
        firstTemperatureLabel.heightAnchor.constraint(equalToConstant: 30),
        firstTemperatureLabel.topAnchor.constraint(equalTo: weatherImageView1.bottomAnchor),
        secondTemperatureLabel.centerXAnchor.constraint(equalTo: weatherImageView2.centerXAnchor),
        secondTemperatureLabel.widthAnchor.constraint(equalTo: weatherImageView2.widthAnchor),
        secondTemperatureLabel.heightAnchor.constraint(equalToConstant: 30),
        secondTemperatureLabel.topAnchor.constraint(equalTo: weatherImageView2.bottomAnchor),
        thirdTemperatureLabel.centerXAnchor.constraint(equalTo: weatherImageView3.centerXAnchor),
        thirdTemperatureLabel.widthAnchor.constraint(equalTo: weatherImageView3.widthAnchor),
        thirdTemperatureLabel.heightAnchor.constraint(equalToConstant: 30),
        thirdTemperatureLabel.topAnchor.constraint(equalTo: weatherImageView3.bottomAnchor),
      ]
    )
  }
  
  private func performAnimations() {
    UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseIn) {
      self.kakImageView.center.x += self.view.bounds.width
    }
    
    UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseIn) {
      self.tamImageView.center.x -= self.view.bounds.width
    }
    
    UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseIn) {
      self.waveImageView.alpha = 1
    }
    
    UIView.animate(withDuration: 0.7, delay: 0.7, usingSpringWithDamping: 0.3, initialSpringVelocity: 20, options: .curveEaseInOut) {
      self.sputnikImageView.setTransformRotation(toDegrees: 13)
    }
    
    UIView.animate(withDuration: 0.5, delay: 0.9, options: .curveEaseIn) {
      self.weatherImageView1.alpha = 1
      self.firstTemperatureLabel.alpha = 1
    }
    
    UIView.animate(withDuration: 0.5, delay: 1.1, options: .curveEaseIn) {
      self.weatherImageView2.alpha = 1
      self.secondTemperatureLabel.alpha = 1
    }
    
    UIView.animate(withDuration: 0.5, delay: 1.3, options: .curveEaseIn) {
      self.weatherImageView3.alpha = 1
      self.thirdTemperatureLabel.alpha = 1
    } completion: { _ in
      if let window = UIApplication.shared.windows.first {
        UIView.animate(withDuration: 0.3, delay: 0,  options: .beginFromCurrentState
        ) {
          window.rootViewController = self.nextViewControllerToShow
        }
      }
    }
  }
}

extension UIView {
  func setTransformRotation(toDegrees angleInDegrees: CGFloat) {
    let angleInRadians = angleInDegrees / 180.0 * CGFloat.pi
    let rotation = self.transform.rotated(by: angleInRadians)
    self.transform = rotation
  }
}




