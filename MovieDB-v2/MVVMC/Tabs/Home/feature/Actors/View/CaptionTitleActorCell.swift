//
//  CaptionTitleActorCell.swift
//  MovieDB-v2
//
//  Created by Imran on 11/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import Foundation
import UIKit

class CaptionTitleActorCell: UITableViewCell, Reusable {
    
    var stackView : UIStackView?
    let titleLbl = UILabel()
    let workTitle = UILabel()
    
    var actor: Artist?
    
    public init(actor: Artist?){ //movie: Result?
        super.init(style: .default, reuseIdentifier: CaptionTitleActorCell.nibName)
        self.actor =  actor
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
        titleLbl.font = UIFont.systemFont(ofSize: 30)
        stackView?.addArrangedSubview(titleLbl)
        
        
        workTitle.textColor = .gray
        workTitle.numberOfLines = 0
        workTitle.font = UIFont.systemFont(ofSize: 18)
        stackView?.addArrangedSubview(workTitle)
    }
    
    func configureCell(){
        titleLbl.text = actor?.name
        workTitle.text = actor?.knownForDepartment
        
    }
    
    required init?(coder: NSCoder) {  fatalError("init(coder:) has not been implemented")  }
}
