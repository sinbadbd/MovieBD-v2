//
//  BottomTabView.swift
//  CustomApp
//
//  Created by Imran on 21/5/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit
var navController: UINavigationController!

class BottomTabView: UIView{
    
    let homeButton = UIButton(type: .system)
    let profileButton = UIButton(type: .custom)
    let settingsButton = UIButton(type: .custom)
    let otherButton = UIButton(type: .custom)
    
    let mainMenuButton = UIButton(type: .custom)
    
    
   // var rainbowCircle = RainbowCircle()
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.addShape()
        setupTabBarUI()
        rotateImageView()
        
        let rainbowCircle = RainbowCircle(frame: CGRect(x: self.frame.width / 2 - 35, y: -35, width: 70, height: 70), lineHeight: 2)
       rainbowCircle.backgroundColor = .clear
       addSubview(rainbowCircle)
    }
    func setupTabBarUI(){
        addSubview(homeButton)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        // homeButton.backgroundColor  = .red
        homeButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        homeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        homeButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        homeButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        homeButton.addTarget(self, action: #selector(handleHomeTap), for: .touchUpInside)
        // homeButton.setTitle("Home", for: .normal)
        homeButton.setTitleColor(.white, for: .normal)
        homeButton.setImage(UIImage(named: "browser"), for: .normal)
        
        
        addSubview(mainMenuButton)
        mainMenuButton.translatesAutoresizingMaskIntoConstraints = false
        mainMenuButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -27).isActive = true
        mainMenuButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        mainMenuButton.widthAnchor.constraint(equalToConstant: 46).isActive = true
        mainMenuButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        mainMenuButton.layer.cornerRadius =  23
        
  
       // mainMenuButton.layer.borderWidth = 4.0
//        mainMenuButton.layer.borderColor = UIColor.blue.cgColor
        mainMenuButton.backgroundColor = .green
        mainMenuButton.setImage(UIImage(named: "gear"), for: .normal)
        
        
//
//        mainMenuButton.addSubview(rainbowCircle!)
//          rainbowCircle?.translatesAutoresizingMaskIntoConstraints = false
//          rainbowCircle?.widthAnchor.constraint(equalToConstant: 65).isActive = true
//          rainbowCircle?.heightAnchor.constraint(equalToConstant: 65).isActive = true
//
        
        
        
        addSubview(profileButton)
        // otherButton.leadingAnchor.constraint(equalTo: mainMenuButton.trailingAnchor, constant: 20).isActive = true
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        // profileButton.backgroundColor = .brown
        profileButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        profileButton.leadingAnchor.constraint(equalTo: homeButton.trailingAnchor, constant: 30).isActive = true
        profileButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        profileButton.addTarget(self, action: #selector(handlePofile), for: .touchUpInside)
        // profileButton.setTitle("Profile", for: .normal)
        // profileButton.setTitleColor(.white, for: .normal)
        profileButton.setImage(UIImage(named: "user"), for: .normal)
        
        addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        // settingsButton.backgroundColor = .brown
        settingsButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        settingsButton.addTarget(self, action: #selector(handleOther), for: .touchUpInside)
        settingsButton.setTitle("Setting", for: .normal)
        settingsButton.setTitleColor(.white, for: .normal)
        settingsButton.setImage(UIImage(named: "gear"), for: .normal)
        
        
        addSubview(otherButton)
        otherButton.translatesAutoresizingMaskIntoConstraints = false
        // otherButton.backgroundColor = .brown
        otherButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        otherButton.leadingAnchor.constraint(equalTo: mainMenuButton.trailingAnchor, constant: 40).isActive = true
        otherButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        otherButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        otherButton.addTarget(self, action: #selector(handleSetting), for: .touchUpInside)
        otherButton.setTitle("Other", for: .normal)
        otherButton.setTitleColor(.white, for: .normal)
        otherButton.setImage(UIImage(named: "clipboard"), for: .normal)
    }
    
    
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 0.1
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    func createPath() -> CGPath {
        
        let height: CGFloat = 37.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // the beginning of the trough
        
        // first curve down
        path.addCurve(to: CGPoint(x: centerWidth, y: height),
                      controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 35, y: height))
        // second curve up
        path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 35, y: height), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))
        
        // complete the rect
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path.cgPath
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let buttonRadius: CGFloat = 35
        return abs(self.center.x - point.x) > buttonRadius || abs(point.y) > buttonRadius
    }
    
    func createPathCircle() -> CGPath {
        
        let radius: CGFloat = 37.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: (centerWidth - radius * 2), y: 0))
        path.addArc(withCenter: CGPoint(x: centerWidth, y: 0), radius: radius, startAngle: CGFloat(180).degreesToRadians, endAngle: CGFloat(0).degreesToRadians, clockwise: false)
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        return path.cgPath
    }
    
    @objc func  handleHomeTap(){
        print("1")
        let vc = DashBoard()
        (superview?.next as? UIViewController)?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handlePofile(){
           print("1")
        let vc = ProfileVC()
        (superview?.next as? UIViewController)?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleSetting(){
           print("1")
        let vc = SettingsVC()
        (superview?.next as? UIViewController)?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleOther(){
           print("1")
        let vc = OtherVC()
        (superview?.next as? UIViewController)?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func rotateImageView()
    {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {() -> Void in
            self.mainMenuButton.transform = self.mainMenuButton.transform.rotated(by: .pi / 2)
           // print("====",self.mainMenuButton.transform )
        }, completion: {(_ finished: Bool) -> Void in
            if finished {
               // print("......")
                self.rotateImageView()
            }
        })
    }
}

extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}
