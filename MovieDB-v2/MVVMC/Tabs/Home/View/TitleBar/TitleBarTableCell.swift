//
//  TitleBarTableCell.swift
//  MovieDB-v2
//
//  Created by Imran on 9/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

 import UIKit

class TitleBarTableCell: UITableViewCell, Reusable {
    
    var stackView : UIStackView?
 
    public init(){
        super.init(style: .default, reuseIdentifier: TitleBarTableCell.nibName)
        backgroundColor = .clear
        selectionStyle = .none
        setupUI()
    }
    
    public required init?(coder: NSCoder) { super.init(coder: coder) }
    
    func setupUI(){
        setupStact()
        addToStack()
    }
    func setupStact(){
        stackView = contentView.VStack(spacing: 0)
        stackView?.fitToSuper(insets: .init(top: 0, left: 16, bottom:0, right: 16))
    }
    
    func addToStack(){
        
    }
 
}
