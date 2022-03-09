//
//  MovieCollectionCell.swift
//  MovieDB-v2
//
//  Created by Imran on 9/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

public class MovieCollectionCell: UICollectionViewCell, Reusable {
    
    let imageView = UIImageView()
    var movieTitle = UILabel()
    var starLabel = UILabel()
    
    let mainView = UIView()
    var stackView : UIStackView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        layer.cornerRadius = 4
        
        setupUI()
    }
    
    func setupUI(){
        addSubview(mainView)
        mainView.fitToSuper()
        
        stackView = mainView.VStack(spacing: 10)
        stackView?.fitToSuper(insets: .init(top: 0, left: 0, bottom:10, right: 0))
        
        imageView.backgroundColor = .red
        stackView?.addArrangedSubview(imageView)

        stackView?.addArrangedSubview(setView())
    
    }
    func setView() -> UIView {
        let view = UIView()
        addSubview(view)
        stackView = view.VStack(spacing: 10)
        stackView?.fitToSuper(insets: .init(top: 0, left: 10, bottom:0, right: 0))

        starLabel.text = "7.8"
        starLabel.font = UIFont.boldSystemFont(ofSize: 14)
        starLabel.textColor = .black
        starLabel.numberOfLines = 0
        stackView?.addArrangedSubview(starLabel)
   
        movieTitle.text = "The Avenger"
        movieTitle.font = UIFont.boldSystemFont(ofSize: 14)
        movieTitle.textColor = .black
        movieTitle.numberOfLines = 0
        
        stackView?.addArrangedSubview(starLabel)
        stackView?.addArrangedSubview(movieTitle)
 
        return view
    }
    
    func configure() {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

