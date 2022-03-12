//
//  ActorImageTitleTableCell.swift
//  MovieDB-v2
//
//  Created by Imran on 12/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import Foundation
import UIKit

class ActorImageTitleTableCell: UITableViewCell, Reusable {
    
    var stackView : UIStackView?
    let posterImage = UIImageView()
    let detailsLbl = UILabel()
    let dateLbl = UILabel()
    var artist: Artist?
    
    public init(artist: Artist?){ //movie: Result?
        super.init(style: .default, reuseIdentifier: BannerImageCell.nibName)
        self.artist =  artist
        setupUI()
    }
    func setupUI(){
        setupStact()
        addToStack()
        configureCell()
    }
    
    func setupStact(){
        stackView = contentView.HStack( spacing: 15, alignment: .center, distribution: .fillProportionally)
        stackView?.fitToSuper(insets: .init(top: 0, left: 15, bottom:0, right: 15))
    }
    
    func addToStack(){
        posterImage.backgroundColor = .clear
        posterImage.size(width:120,height: 180)
        posterImage.contentMode = .scaleAspectFit
        posterImage.layer.masksToBounds = true
        //        posterImage.clipsToBounds = true
        posterImage.layer.cornerRadius = 6
        stackView?.addArrangedSubview(posterImage)
        
        let detaiV = UIView()
        let conv = detaiV.VStack( spacing: 20)
        stackView?.addArrangedSubview(conv)

        
        detailsLbl.numberOfLines = 6
        detailsLbl.font = UIFont.systemFont(ofSize: 14)
        detailsLbl.textColor = .lightGray
        
        dateLbl.numberOfLines = 1
        dateLbl.font = UIFont.boldSystemFont(ofSize: 18)
        dateLbl.textColor = .lightGray
        
        conv.addArrangedSubview(detailsLbl)
        conv.addArrangedSubview(dateLbl)

    }
    
    func configureCell(){
        let img =  URL(string: "\(APIClient.EndPoints.PROFILE_URL + (artist?.profilePath ?? ""))")
        posterImage.sd_setImage(with: img, completed: nil)
        detailsLbl.text = artist?.biography
        dateLbl.text = "Born: \(artist?.birthday ?? "")"
    }
    
    required init?(coder: NSCoder) {  fatalError("init(coder:) has not been implemented")  }
}
