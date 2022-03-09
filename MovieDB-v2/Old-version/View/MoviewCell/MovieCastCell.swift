//
//  MovieCastCell.swift
//  MovieDB-v2
//
//  Created by Imran on 20/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit
class MovieCastCell : UICollectionViewCell {
    
    let imageView : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        return image
    }()
    
    let titleNowPlayingMovie = MyUILabel(frame: .zero, text: "gggg", textColor: .black, fontSize: UIFont(name: appFont, size: 12), textAlign: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowRadius = 5.0
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: CGSize(width: 100, height: 150))
        
        addSubview(titleNowPlayingMovie)
        titleNowPlayingMovie.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        titleNowPlayingMovie.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
