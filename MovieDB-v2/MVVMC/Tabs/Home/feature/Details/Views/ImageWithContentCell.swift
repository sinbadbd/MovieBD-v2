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
    
    public init(movie: Result?){ //movie: Result?
        super.init(style: .default, reuseIdentifier: BannerImageCell.nibName)
        self.movie =  movie
        setupUI()
    }
    func setupUI(){
        setupStact()
        addToStack()
        configureCell()
    }
    
    func setupStact(){
        stackView = contentView.HStack( spacing: 15, alignment: .leading, distribution: .fillProportionally)
        stackView?.fitToSuper(insets: .init(top: 0, left: 15, bottom:0, right: 15))
    }
    
    func addToStack(){
        posterImage.backgroundColor = .clear
        posterImage.size(width:120,height: 180,widthPriority: 250)
        posterImage.contentMode = .scaleAspectFit
        posterImage.layer.masksToBounds = true
//        posterImage.clipsToBounds = true
        posterImage.layer.cornerRadius = 6
        stackView?.addArrangedSubview(posterImage)

        detailsLbl.numberOfLines = 6
        detailsLbl.font = UIFont.systemFont(ofSize: 14)
        detailsLbl.textColor = .lightGray
        
        stackView?.addArrangedSubview(detailsLbl)
    }
    
    func configureCell(){
        let img =  URL(string: "\(APIClient.EndPoints.POSTER_URL + (movie?.posterPath ?? ""))")
        posterImage.sd_setImage(with: img, completed: nil)
        detailsLbl.text = movie?.overview
    }
    
    required init?(coder: NSCoder) {  fatalError("init(coder:) has not been implemented")  }
}
