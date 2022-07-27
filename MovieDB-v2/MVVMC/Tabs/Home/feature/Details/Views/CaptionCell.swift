//
//  CaptionCell.swift
//  MovieDB-v2
//
//  Created by Imran on 10/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

class CaptionCell: UITableViewCell, Reusable {
    
    var stackView : UIStackView?
    let titleLbl = UILabel()
    
    var movie: Result?
    
    public init(movie: Result?){ //movie: Result?
        super.init(style: .default, reuseIdentifier: CaptionCell.nibName)
        self.movie =  movie
        setupUI()
    }
    
    
    func setupUI(){
        setupStact()
        addToStack()
        configureCell()
    }
    func setupStact(){
        stackView = contentView.VStack(spacing: 0)
        stackView?.fitToSuper(insets: .init(top: 0, left: 20, bottom:0, right: 20))
    }
    func addToStack(){
        
        titleLbl.textColor = .black
        titleLbl.numberOfLines = 0
        titleLbl.font = UIFont.systemFont(ofSize: 24)
        stackView?.addArrangedSubview(titleLbl)
    }
    
    func configureCell(){
        titleLbl.text = movie?.title
    }
    
    required init?(coder: NSCoder) {  fatalError("init(coder:) has not been implemented")  }
}
