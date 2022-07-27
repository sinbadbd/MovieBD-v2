//
//  AlertView.swift
//  CustomApp
//
//  Created by Imran on 5/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit
class AlertView: UIView {
    
    let mainContainer = UIView()
    let contentView = UIView()
    
    let statusImage = UIImageView()
    var titleLabel = MyUILabel()
    var desLabel = MyUILabel()
    var submitButton = MyButton()
    
    //    var alertView =  AlertView(frame: .zero)
    
    let visualEffect : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    enum AlertType {
        case success
        case Failed
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    func setupUI(){
        
        addSubview(mainContainer)
        mainContainer.anchor(top: topAnchor,
                             leading: leadingAnchor,
                             bottom: bottomAnchor,
                             trailing: trailingAnchor,
                             padding: .init(),
                             size: .init(width: mainContainer.frame.width,
                                         height: mainContainer.frame.height)
        )
        mainContainer.backgroundColor = .black
        mainContainer.alpha = 0.8
        
        mainContainer.addSubview(contentView)
        contentView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(), size: .init(width: 300, height: 300))
        contentView.centerInSuperview()
        contentView.alpha = 1
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 4
        
        
        contentView.addSubview(statusImage)
        statusImage.anchor(top: contentView.topAnchor,
                           leading: nil,
                           bottom: nil,
                           trailing: nil,
                           padding: .init(top: -30, left: 0, bottom: 0, right: 0),
                           size: .init(width: 60, height: 60)
        )
        statusImage.image = UIImage(named: "success")!.withRenderingMode(.alwaysTemplate)
        statusImage.layer.cornerRadius = 30
        statusImage.backgroundColor = .white
        statusImage.centerXInSuperview()
        
        //        statusImage.isUserInteractionEnabled = true
        //        statusImage.addGestureRecognizer(.init(target: self, action: #selector(closeAlert)))
        
        
        self.titleLabel = MyUILabel( text: "Success", textColor: .green, fontSize: UIFont.systemFont(ofSize: 30), textAlign: .center)
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: statusImage.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(width: .init(), height: titleLabel.frame.height))
        
        
        
        self.desLabel = MyUILabel(text: "Following are the code snippets that describe the various ways to initialize a struct.", textColor: .black, fontSize: UIFont.systemFont(ofSize: 16), textAlign: .center)
        contentView.addSubview(desLabel)
        desLabel.anchor(top: titleLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(width: .init(), height: desLabel.frame.height))
        
        
        self.submitButton = MyButton(frame: .zero, setTitle: "Done", bgColor: .green, textColor: .black)
        contentView.addSubview(submitButton)
        
        submitButton.anchor(top: desLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: 20), size: .init(width: submitButton.frame.width , height: 45))
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:  #selector(closeAlert))
        submitButton.isUserInteractionEnabled = true
        submitButton.addGestureRecognizer(tap)
    }
    
    @objc func closeAlert(_ sender: UITapGestureRecognizer? = nil){
        removeFromSuperview()
    }
    
    
    func showAlert(title:String, message:String, alertType:AlertType){
        self.titleLabel.text = title
        self.desLabel.text = message
        switch alertType {
        case .success:
            titleLabel.textColor = .green
            statusImage.image = UIImage(named: "success")
            submitButton.setTitle("Login...", for: .normal)
            submitButton.backgroundColor = .green
        default:
            titleLabel.textColor = .red
            statusImage.image = UIImage(named: "error")
            submitButton.backgroundColor = .red
            submitButton.setTitle("Close", for: .normal)
        }
    }
    
    
    
    func showAlertMessage(){
        print("show message")
        //        self.addSubview(AlertView .addSubview(superview))
        //        self.didAddSubview(superview.autoresizesSubviews)
        //        addSubview(self)
        // if superview != nil {
        self.addSubview(.init(frame: .infinite))
        self.anchor(top: self.superview?.safeAreaLayoutGuide.topAnchor,
                    leading: self.superview?.leadingAnchor,
                    bottom: self.superview?.bottomAnchor,
                    trailing: self.superview?.trailingAnchor,
                    padding: .init(),
                    size: .init(width:self.frame.width, height: self.frame.height))
        
        //    }
        
        //        UIApplication.shared.keyWindow?.addSubview(mainContainer)
        //        UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        //        UIApplication.shared.windows.a
        
        //        UIApplication.shared.windows.first { $0.isKeyWindow }
        if #available(iOS 13.0, *) {
            if let app = UIApplication.shared.delegate as? AppDelegate{
                //            MBProgressHUD.show(text, view:window)
                addSubview(mainContainer)
                //            app.addS
            }
        } else {
            // Fallback on earlier versions
        }
        
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
