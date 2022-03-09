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
    
    let colorView = UIView()
    let titleInfo = UILabel()
    let seeAllButton = UIButton()
    var onButtonTapped: (() -> Void)?
    
    public init(){ //color: UIColor?, title: String?, seeAll: String?
        super.init(frame: .zero)
        backgroundColor = .clear
        setupUI()
        Log.info()
    }
    
    public required init?(coder: NSCoder) { super.init(coder: coder) }
    
    func setupUI(){
        setupStact()
        addToStack()
    }
    
    func setupStact(){
        addSubview(mainView)
        mainView.fitToSuper()

        stackView = mainView.HStack( spacing: 6, distribution: .fill)
        stackView?.fitToSuper(insets: .init(top: 0, left: 0, bottom:0, right: 0))
    }
    
    func addToStack(){
        colorView.size(width: 6)
        colorView.layer.cornerRadius = 2
        stackView?.addArrangedSubview(colorView)
        
      
        titleInfo.font = UIFont.boldSystemFont(ofSize: 16)
        titleInfo.textColor = .black
        titleInfo.numberOfLines = 0
        stackView?.addArrangedSubview(titleInfo)
        
       
        seeAllButton.setTitleColor(.black, for: .normal)
        seeAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        seeAllButton.size(width: 50, widthPriority: 250)
        seeAllButton.addTarget(self, action: #selector(handleBtnTapped), for: .touchUpInside)
        stackView?.addArrangedSubview(seeAllButton)
    }
    
    func getTitleInfo(color: UIColor?, title: String?, seeAll: String?){
        colorView.backgroundColor = color
        titleInfo.text = title
        seeAllButton.setTitle(seeAll, for: .normal)
    }
    
    @objc func handleBtnTapped(){
        onButtonTapped?()
        Log.info()
    }
    
    
}
