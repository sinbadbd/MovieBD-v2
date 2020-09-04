//
//  ProfileVC.swift
//  MovieDB-v2
//
//  Created by Imran on 19/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit

class ProfileVC: BaseVC {

    let test = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isTopbar = false
        isShowBottomTab = false
        resetBase()
        
        setupView()
    }
    func setupView(){
        let hederView = UIView()
        contentView.addSubview(hederView)
        hederView.position(top: view.safeAreaLayoutGuide.topAnchor, insets: .init(top: 0, left: 0, bottom: 0, right: 0))
        hederView.size( height: 150, dimensionWidth: contentView.widthAnchor)
        hederView.backgroundColor = .red
        
        
        let logoView = UIView()
        contentView.addSubview(logoView)
        logoView.position(top: hederView.bottomAnchor, insets: .init(top: -50, left: 0, bottom: 0, right: 0))
        logoView.size(  width: 100, height: 100)
        logoView.layer.cornerRadius = 50
        logoView.centerXInSuper()
        logoView.backgroundColor = .green
        
        let btn1 = UIButton()
        contentView.addSubview(btn1)
        btn1.position(top: logoView.bottomAnchor, bottom: contentView.bottomAnchor)
        btn1.size( width: 200, height: 100)
        btn1.backgroundColor = .blue
        btn1.addTarget(self, action: #selector(favoriteBtn), for: .touchUpInside)
        btn1.setTitle("Favorite", for: .normal)
    }
    
    @objc func favoriteBtn(){
        print("hi")
        let vc = UserMovieList()
        navigationController?.pushViewController(vc, animated: true)
    }
}
