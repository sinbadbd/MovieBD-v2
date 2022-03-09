//
//  ProfileVC.swift
//  MovieDB-v2
//
//  Created by Imran on 19/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileVC: BaseVC {

    let test = UILabel()
    
    let userData : UserModel? = nil
    var userArray = [String:Any]()
    
    var userName = ""
    
    var imageURL = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isTopbar = false
        isShowBottomTab = false
        resetBase()
        getServerdata()
        setupView()
    }
    func setupView(){
        let hederView = UIView()
        contentView.addSubview(hederView)
        hederView.position(top: view.safeAreaLayoutGuide.topAnchor, insets: .init(top: 0, left: 0, bottom: 0, right: 0))
        hederView.size( height: 150, dimensionWidth: contentView.widthAnchor)
        hederView.backgroundColor = .red
        
        
        let logoView = UIImageView()
        contentView.addSubview(logoView)
        logoView.position(top: hederView.bottomAnchor, insets: .init(top: -50, left: 0, bottom: 0, right: 0))
        logoView.size(  width: 100, height: 100)
        logoView.layer.cornerRadius = 50
        logoView.centerXInSuper()
        let url = URL(string: self.imageURL)
        print("url:\(String(describing: url))")
        logoView.sd_setImage(with: url, completed: nil)
        logoView.backgroundColor = .green
        
        let btn1 = UIButton()
        contentView.addSubview(btn1)
        btn1.position(top: logoView.bottomAnchor, bottom: contentView.bottomAnchor, insets: .init(top: 10, left: 10, bottom: 0, right: 0))
        btn1.size( width: 100, height: 100)
        btn1.backgroundColor = .blue
        btn1.addTarget(self, action: #selector(favoriteBtn), for: .touchUpInside)
        btn1.setTitle("Favorite", for: .normal)
        
        
        let btn2 = UIButton()
        contentView.addSubview(btn2)
        btn2.position(top: logoView.bottomAnchor,left:btn1.trailingAnchor , bottom: contentView.bottomAnchor, insets: .init(top: 10, left: 10, bottom: 0, right: 10))
        btn2.size( width: 100, height: 100)
        btn2.backgroundColor = .blue
        btn2.addTarget(self, action: #selector(watchListbtn), for: .touchUpInside)
        btn2.setTitle("Watch List", for: .normal)
    }
    
    
    func getServerdata(){
        APIClient.getUserProfileData { (response, error) in
            if let response = response {
                print(response)
                self.userName = response.name
                self.imageURL =  response.avatar.gravatar.hash
                print("self.imageURL: \(self.imageURL)")
//                self.userArray = response.
            }
        }
    }
    @objc func favoriteBtn(){
        print("hi")
        let vc = UserMovieList()
        vc.isChangeView = 0
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func watchListbtn(){
        print("hi")
        let vc = UserMovieList()
        vc.isChangeView = 1
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
