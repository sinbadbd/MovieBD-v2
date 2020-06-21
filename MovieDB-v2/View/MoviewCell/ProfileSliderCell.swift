//
//  ProfileSliderCell.swift
//  MovieDB-v2
//
//  Created by Imran on 20/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import Foundation
import UIKit
class ProfileSliderCell : UICollectionViewCell {
    let imageSlider : UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageSlider)
       // imageSlider.backgroundColor = .blue
        imageSlider.contentMode = .scaleAspectFill
        imageSlider.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        imageSlider.translatesAutoresizingMaskIntoConstraints = false
        
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
