//
//  MoviesCastCollectionCell.swift
//  MovieDB-v2
//
//  Created by Imran on 10/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import Foundation

import UIKit
import SDWebImage

public class MoviesCastCollectionCell: UICollectionViewCell, Reusable {
    
    let imageView = UIImageView()
    var movieTitle = UILabel()
    var starLabel = UILabel()
    
    let mainView = UIView()
    var stackView : UIStackView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 4
        shadowForViewLight(shadow: self)
        setupUI()
    }
    
    func setupUI(){
        addSubview(mainView)
        mainView.fitToSuper()
        
        stackView = mainView.VStack(spacing: 10)
        stackView?.fitToSuper(insets: .init(top: 0, left: 0, bottom:10, right: 0))
        
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.size(height:150, heightPriority: 250)
        stackView?.addArrangedSubview(imageView)

        stackView?.addArrangedSubview(setView())
    
    }
    func setView() -> UIView {
        let view = UIView()
        addSubview(view)
        stackView = view.VStack(spacing: 0)
        stackView?.fitToSuper(insets: .init(top: 0, left: 10, bottom:0, right: 0))


        starLabel.font = UIFont.boldSystemFont(ofSize: 14)
        starLabel.textColor = .black
        starLabel.numberOfLines = 0
//        stackView?.addArrangedSubview(starLabel)
   
        movieTitle.text = "--"
        movieTitle.font = UIFont.boldSystemFont(ofSize: 14)
        movieTitle.textColor = .black
        movieTitle.numberOfLines = 0
        
        stackView?.addArrangedSubview(movieTitle)
 
        return view
    }
    
    func configureCell(poster: URL?, title: String?) {
        imageView.sd_setImage(with: poster, completed: nil)
        movieTitle.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}