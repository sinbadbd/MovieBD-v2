//
//  WishListButtonCell.swift
//  MovieDB-v2
//
//  Created by Imran on 10/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class WishListButtonCell: UITableViewCell, Reusable {
    
    var stackView : UIStackView?
    let addWishButton = UIButton()
    
    var movie: Result?
    
    public init(){ //movie: Result?
        super.init(style: .default, reuseIdentifier: BannerImageCell.nibName)
//        self.movie =  movie
        setupUI()
    }
    func setupUI(){
        setupStact()
        addToStack()
    }
    func setupStact(){
        stackView = contentView.VStack(spacing: 0)
        stackView?.fitToSuper(insets: .init(top: 0, left: 15, bottom:0, right: 15))
    }
    func addToStack(){
        addWishButton.setTitle("Add to Watchlist", for: .normal)
        addWishButton.setTitleColor(.systemBlue, for: .normal)
        addWishButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        addWishButton.backgroundColor = .lightGray
        addWishButton.layer.cornerRadius = 4
        addWishButton.size(height:50,heightPriority: 250)
        addWishButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        stackView?.addArrangedSubview(addWishButton)
    }
    @objc func handleTap(){
        Log.info()
    }
    
    func configureCell(){
        
    }
    
    required init?(coder: NSCoder) {  fatalError("init(coder:) has not been implemented")  }
}
