//
//  ImageWithContentCell.swift
//  MovieDB-v2
//
//  Created by Imran on 10/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

class ImageWithContentCell: UITableViewCell, Reusable {
    
    var stackView : UIStackView?
    let posterImage = UIImageView()
    let detailsLbl = UILabel()
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
        stackView = contentView.HStack( spacing: 15, alignment: .leading, distribution: .fillProportionally)
        stackView?.fitToSuper(insets: .init(top: 0, left: 15, bottom:0, right: 15))
    }
    
    func addToStack(){
        posterImage.backgroundColor = .systemGreen
        posterImage.size(width:140,height: 140,widthPriority: 250)
        posterImage.contentMode = .scaleAspectFit
        posterImage.layer.cornerRadius = 4
        stackView?.addArrangedSubview(posterImage)
       
        detailsLbl.text = "This 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day valThis 7-day"
        detailsLbl.numberOfLines = 4
        detailsLbl.font = UIFont.systemFont(ofSize: 14)
        detailsLbl.textColor = .lightGray
        
        stackView?.addArrangedSubview(detailsLbl)
    }
    
    func configureCell(){
        
    }
    
    required init?(coder: NSCoder) {  fatalError("init(coder:) has not been implemented")  }
}
