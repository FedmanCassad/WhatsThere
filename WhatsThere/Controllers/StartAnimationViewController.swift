
//
//  ViewController.swift
//  WeatherDesign
//
//  Created by Ivan Belyakov on 06.03.2021.
//

import UIKit

class StartAnimationViewController: UIViewController {
  
  let kakImageView:UIImageView = UIImageView()
  let tamImageView:UIImageView = UIImageView()
  let sputnikImageView:UIImageView = UIImageView()
  let waweImageView:UIImageView = UIImageView()
  
  let weatherImageView1:UIImageView = UIImageView()
  let weatherImageView2:UIImageView = UIImageView()
  let weatherImageView3:UIImageView = UIImageView()
  let label1 = UILabel()
  let label2 = UILabel()
  let label3 = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let viewLS = UIView()
    viewLS.frame = view.bounds
    viewLS.backgroundColor = UIColor(red: 0.19, green: 0.34, blue: 0.38, alpha: 1.00)
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
    viewLS.addSubview(earthImageView)
    let sun = UIImage(named: "sun")
    let sunImageView:UIImageView = UIImageView()
    sunImageView.contentMode = UIView.ContentMode.scaleAspectFit
    sunImageView.frame = CGRect(
      //  x:
      x:  -viewLS.frame.size.width / 2,
      y: -viewLS.frame.size.height / 2,
      width: viewLS.frame.size.width,
      height: viewLS.frame.size.height
    )
    sunImageView.image = sun
    viewLS.addSubview(sunImageView)
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
    viewLS.addSubview(moonImageView)
    let sputnik = UIImage(named: "sputnik")
    sputnikImageView.contentMode = UIView.ContentMode.scaleAspectFit
    sputnikImageView.frame = CGRect(
      x:  viewLS.frame.size.width / 2 - viewLS.frame.size.width / 2.4 / 2,
      y: viewLS.frame.size.height / 2 - viewLS.frame.size.height / 7 ,
      width: viewLS.frame.size.width / 2.4,
      height: viewLS.frame.size.height / 8.3
    )
    self.sputnikImageView.setTransformRotation(toDegrees: -13)
    sputnikImageView.image = sputnik
    viewLS.addSubview(sputnikImageView)
    let kak = UIImage(named: "kak")
    kakImageView.contentMode = UIView.ContentMode.scaleAspectFit
    kakImageView.frame = CGRect(
      x: sputnikImageView.center.x - viewLS.frame.size.width / 3.45 - 40,
      y: sputnikImageView.center.y - viewLS.frame.size.height / 16 - 20,
      width: viewLS.frame.size.width / 3.45,
      height: viewLS.frame.size.height / 16
    )
    self.kakImageView.center.x -= self.view.bounds.width
    kakImageView.image = kak
    viewLS.addSubview(kakImageView)
    let tam = UIImage(named: "tam")
    tamImageView.contentMode = UIView.ContentMode.scaleAspectFit
    tamImageView.frame = CGRect(
      x: sputnikImageView.center.x + 40,
      y: sputnikImageView.center.y + kakImageView.frame.size.height / 1.32 - 20,
      width: kakImageView.frame.size.width,
      height: kakImageView.frame.size.height / 1.32
    )
    self.tamImageView.center.x += self.view.bounds.width
    tamImageView.image = tam
    viewLS.addSubview(tamImageView)
    
    let wawe = UIImage(named: "wawe")
    waweImageView.contentMode = UIView.ContentMode.scaleAspectFit
    waweImageView.frame = CGRect(
      x: (sputnikImageView.center.x - viewLS.frame.size.width / 2.4 * 1.238 / 2) + 0.15 * (sputnikImageView.center.x - viewLS.frame.size.width / 2.4 * 1.238 / 2) ,
      y: sputnikImageView.center.y + viewLS.frame.size.height / 8.3 / 1.5,
      width: viewLS.frame.size.width / 2.4 * 1.238,
      height: viewLS.frame.size.height / 8.3
    )
    waweImageView.image = wawe
    let overlayView = waweImageView
    overlayView.layer.compositingFilter = "overlayBlendMode"
    waweImageView.alpha = 0
    viewLS.addSubview(waweImageView)
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
    earthImageView.addSubview(weatherImageView1)
    label1.textAlignment = .center
    label1.text = "+13"
    label1.font = .boldSystemFont(ofSize: 25)
    label1.backgroundColor = .init(white: 1, alpha: 0.5)
    label1.translatesAutoresizingMaskIntoConstraints = false
    label1.alpha = 0
    earthImageView.addSubview(label1)
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
    earthImageView.addSubview(weatherImageView2)
    label2.textAlignment = .center
    label2.text = "+17"
    label2.font = .boldSystemFont(ofSize: 25)
    label2.backgroundColor = .init(white: 1, alpha: 0.5)
    label2.translatesAutoresizingMaskIntoConstraints = false
    label2.alpha = 0
    earthImageView.addSubview(label2)
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
    earthImageView.addSubview(weatherImageView3)
    label3.textAlignment = .center
    label3.text = "+21"
    label3.font = .boldSystemFont(ofSize: 25)
    label3.backgroundColor = .init(white: 1, alpha: 0.5)
    label3.translatesAutoresizingMaskIntoConstraints = false
    label3.alpha = 0
    earthImageView.addSubview(label3)
    let commonConstraints: [NSLayoutConstraint] = [
      label1.centerXAnchor.constraint(equalTo: weatherImageView1.centerXAnchor),
      label1.widthAnchor.constraint(equalTo: weatherImageView1.widthAnchor),
      label1.heightAnchor.constraint(equalToConstant: 30),
      label1.topAnchor.constraint(equalTo: weatherImageView1.bottomAnchor),
      
      label2.centerXAnchor.constraint(equalTo: weatherImageView2.centerXAnchor),
      label2.widthAnchor.constraint(equalTo: weatherImageView2.widthAnchor),
      label2.heightAnchor.constraint(equalToConstant: 30),
      label2.topAnchor.constraint(equalTo: weatherImageView2.bottomAnchor),
      
      label3.centerXAnchor.constraint(equalTo: weatherImageView3.centerXAnchor),
      label3.widthAnchor.constraint(equalTo: weatherImageView3.widthAnchor),
      label3.heightAnchor.constraint(equalToConstant: 30),
      label3.topAnchor.constraint(equalTo: weatherImageView3.bottomAnchor),
    ]
    NSLayoutConstraint.activate(commonConstraints)
    
    self.view = viewLS
    print("\(viewLS.frame.size.width) , \(viewLS.frame.size.height)")
    print("Sputnik \(sputnikImageView.frame.size.width) , \(sputnikImageView.frame.size.height)")
    print("Wawe \(waweImageView.frame.size.width) , \(waweImageView.frame.size.height)")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseIn, animations: {
      
      self.kakImageView.center.x += self.view.bounds.width
    }, completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseIn, animations: {
      
      self.tamImageView.center.x -= self.view.bounds.width
    }, completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseIn, animations: {
      
      self.waweImageView.alpha = 1
    }, completion: nil)
    
    UIView.animate(withDuration: 0.7, delay: 0.7, usingSpringWithDamping: 0.3, initialSpringVelocity: 20, options: .curveEaseInOut, animations: {
      self.sputnikImageView.setTransformRotation(toDegrees: 13)
    }, completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 0.9, options: .curveEaseIn, animations: {
      
      self.weatherImageView1.alpha = 1
      self.label1.alpha = 1
    }, completion: nil)
    UIView.animate(withDuration: 0.5, delay: 1.1, options: .curveEaseIn, animations: {
      
      self.weatherImageView2.alpha = 1
      self.label2.alpha = 1
    }, completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 1.3, options: .curveEaseIn, animations: {
      
      self.weatherImageView3.alpha = 1
      self.label3.alpha = 1
    }, completion: {didFinished in
      if let window = UIApplication.shared.windows.first {
        let mainVC = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainVC)
        UIView.animate(withDuration: 0.3, delay: 0,  options: .beginFromCurrentState
        ) {
        window.rootViewController = navigationController
        }
      }
    })
  }
}

extension UIView {
  func setTransformRotation(toDegrees angleInDegrees: CGFloat) {
    let angleInRadians = angleInDegrees / 180.0 * CGFloat.pi
    let rotation = self.transform.rotated(by: angleInRadians)
    self.transform = rotation
  }
}

