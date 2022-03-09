//
//  TitleBarView.swift
//  MovieDB-v2
//
//  Created by Imran on 9/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

class TitleBarView: UIView {
    
    var stackView : UIStackView?
    var mainView = UIView()
    
    public init(){
        super.init(frame: .zero)
        backgroundColor = .clear
        setupUI()
    }
    
    public required init?(coder: NSCoder) { super.init(coder: coder) }
    
    func setupUI(){
        setupStact()
        addToStack()
    }
    func setupStact(){
        stackView = mainView.VStack(spacing: 0)
        stackView?.fitToSuper(insets: .init(top: 0, left: 16, bottom:0, right: 16))
    }
    
    func addToStack(){
        
    }
 
}
