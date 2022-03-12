//
//  DummyImageCell.swift
//  MovieDB-v2
//
//  Created by Imran on 12/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

class DummyImageCell: UITableViewCell, Reusable {
    
    var stackView : UIStackView?
    let imageV = UIImageView()
    
    var movie: Result?
    
    public init(img: UIImage?){
        super.init(style: .default, reuseIdentifier: DummyImageCell.nibName)
        imageV.image = img
//        self.movie =  movie
        setupUI()
    }
    func setupUI(){
        setupStact()
        addToStack()
        configureCell()
    }
    func setupStact(){
        contentView.size(height: 200)
        stackView = contentView.HStack(spacing: 0)
        stackView?.fitToSuper(insets: .init(top: 0, left: 0, bottom:0, right: 0))
    }
    func addToStack(){
        
//        titleLbl.textColor = .black
//        titleLbl.numberOfLines = 0
//        titleLbl.font = UIFont.systemFont(ofSize: 16)
        imageV.backgroundColor = .systemGray5
        imageV.size(height: 200, heightPriority: 200)
        imageV.contentMode = .scaleAspectFit
        stackView?.addArrangedSubview(imageV)
    }
    
    func configureCell(){
         
    }
    
    required init?(coder: NSCoder) {  fatalError("init(coder:) has not been implemented")  }
}
