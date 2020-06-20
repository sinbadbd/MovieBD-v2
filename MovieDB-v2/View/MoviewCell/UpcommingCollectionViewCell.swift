//
//  UpcommingCollectionViewCell.swift
//  MovieDB-v2
//
//  Created by Imran on 19/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit

class  UpcommingCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    var movieTitle = MyUILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         padding: .init()
        )
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        
        self.movieTitle = MyUILabel(frame: .zero, text: "installation with CocoaPods", textColor: .white, fontSize: UIFont.systemFont(ofSize: 18), textAlign: .left)
        imageView.addSubview(movieTitle)
        movieTitle.anchor(top: nil,
                     leading: imageView.leadingAnchor,
                     bottom: imageView.bottomAnchor,
                     trailing: nil,
                     padding: .init(top: 0, left: 20, bottom: 10, right: 0),
                     size: .init(width: movieTitle.frame.width, height: movieTitle.frame.height)
        )
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
