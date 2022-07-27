//
//  MainTopbarTableCell.swift
//  MovieDB-v2
//
//  Created by Imran on 9/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit
import SnapKit

class MainTopbarTableCell : UITableViewCell, Reusable {
    
    let mainTtopBar = MainTopBar()
    var stackView : UIStackView?
    
    public init(){
        super.init(style: .default, reuseIdentifier: MainTopbarTableCell.nibName)
        backgroundColor = .clear
        selectionStyle = .none
        setupUI()
    }
    
    func setupUI(){
        stackView = contentView.VStack(spacing: 0)
        stackView?.fitToSuper(insets: .init(top: 0, left: 20, bottom:0, right: 20))
        stackView?.addArrangedSubview(mainTtopBar)

    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
