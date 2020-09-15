//
//  BaseVC.swift
//  MovieDB-v2
//
//  Created by Imran on 19/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit

extension UIApplication {

   var statusBarView: UIView? {
      return value(forKey: "statusBar") as? UIView
    }

}
class BaseVC: UIViewController {
    var isTopbar = true
    var isTLogo = true
    var isShowBottomTab = true
    var isCustomBgColor = false
    var topbarTitle = ""//maximus
    let scrollView = UIScrollView(),
    contentView = UIView(),
    topBarView = UIView(),
    containerView = UIView(),
    statusBarView = UIView(),
    logoView = UIImageView(),
    titleLbl = UILabel()
    var statusBarHeight:NSLayoutConstraint?,
    topBarHeight:NSLayoutConstraint?
    //contentHeight:NSLayoutConstraint?
    
    
    var bottomView : BottomTabView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        

        self.view.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(statusBarView)
        
        
        statusBarHeight = statusBarView.heightAnchor.constraint(equalToConstant: UIApplication.shared.statusBarFrame.height)
        statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        statusBarView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        statusBarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        //statusBarView.heightAnchor.constraint(equalToConstant: ).isActive = true
        statusBarHeight!.isActive = true
        
        topBarView.clipsToBounds = true
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(topBarView)
        
        topBarHeight = topBarView.heightAnchor.constraint(equalToConstant: 40.dynamic())
        topBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBarView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topBarView.topAnchor.constraint(equalTo: statusBarView.bottomAnchor).isActive = true
        topBarHeight!.isActive = true
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        self.view.addConstraints([
            //NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: scrollView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: topBarView, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        ])
        
        /*
         
         scrollView.position(top: topBarView.bottomAnchor)
         scrollView.size(width: self.view.frame.size.width)
         
         
         let wAnchorContent = contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
         contentView.position(top: scrollView.topAnchor, bottom: scrollView.bottomAnchor)
         contentView.size(wAnchor: wAnchorContent)
         
         */
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        //contentHeight = NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 0)
        
        scrollView.addConstraints([
            //NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            //contentHeight!
        ])
        
        setupTopbar()
        
        /*
         DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
         //self.contentHeight!.constant = 5000
         self.resetBase()
         
         }
         */
        
    }
    
    func resetBase() {
        if !isCustomBgColor {
            self.view.backgroundColor = .white
        }
        titleLbl.text = topbarTitle
        if !isTopbar {
            topBarHeight!.constant = 0
        }
        if isTLogo {
            setViewBackgroundImageDash(vc: self)
        }
   
        self.view.layoutIfNeeded()
        //self.contentHeight!.constant = scrollView.frame.size.height//max
        if isShowBottomTab{
               setupBottomTabBar()
           }
    }
    func setupBottomTabBar(){
        bottomView = BottomTabView()
        bottomView?.delegate = self
        contentView.addSubview(bottomView!)
        bottomView?.position( bottom: view.bottomAnchor, right: nil, insets: .init(top: 0, left: 0, bottom: 0, right: 0))
        bottomView?.size(wAnchor: nil, hAnchor: nil,  height: 70, dimensionWidth: contentView.widthAnchor)
       bottomView?.layer.zPosition = 999999

     }


//    }
    func setContentHeight(height:CGFloat) {
        //self.contentHeight!.constant = height+20.dynamic()//max
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setupTopbar() {
        titleLbl.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: topBarHeight!.constant)
        titleLbl.textColor = txtColorBlue
        //        titleLbl.font = UIFont(name: appFont, size: 22.dynamic())
        titleLbl.textAlignment = .center
        topBarView.addSubview(titleLbl)
        //
        //        let imgSz = CGSize(width: 15.dynamic(),  height: 15.dynamic())
        //        let backButton = getButtonWithImage(frame: CGRect(x: 0, y: 0, width: 45.dynamic(), height:titleLbl.frame.size.height), imgName: "iosBack.png", imgSz: CGSize(width: imgSz.width, height: imgSz.height), imgClr: hexToUIColor(hex: "#007AD0"))
        //        backButton.addTarget(self, action: #selector(topBtnPressed), for: .touchUpInside)
        //        topBarView.addSubview(backButton)
        
    }
    
    @objc func topBtnPressed(sender:UIButton) {
        UIView.animate(withDuration: TimeInterval(0.1), delay: 0.0, options: [], animations: {
            sender.alpha = 0.5
        }) { finished in
            sender.alpha = 1.0
            sender.isEnabled = false
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
}
 


extension BaseVC: BottomViewProtocol {
    func profileBtn(sender: UIButton) {
        let vc = ProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
