//
//  BannerImageCell.swift
//  MovieDB-v2
//
//  Created by Imran on 10/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import Foundation
import UIKit

class BannerImageCell: UITableViewCell, Reusable {
    
    var stackView : UIStackView?
    let bannerImg = UIImageView()
    
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
        stackView = contentView.VStack(spacing: 0)
        stackView?.fitToSuper(insets: .init(top: 0, left: 0, bottom:0, right: 0))
    }
    func addToStack(){
        bannerImg.backgroundColor = .clear
        bannerImg.size(height: 200,heightPriority: 250)
        bannerImg.contentMode = .scaleAspectFill
        stackView?.addArrangedSubview(bannerImg)
    }
    
    func configureCell(){
        let img =  URL(string: "\(APIClient.EndPoints.BACKDROP_PATH + (movie?.backdropPath)!)")
        bannerImg.sd_setImage(with: img, completed: nil)

     }
    
    required init?(coder: NSCoder) {  fatalError("init(coder:) has not been implemented")  }
}
