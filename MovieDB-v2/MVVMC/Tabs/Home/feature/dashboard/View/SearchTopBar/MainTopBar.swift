//
//  MainTopBar.swift
//  MovieDB-v2
//
//  Created by Imran on 9/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit
import SnapKit

class MainTopBar: UIView, UITextFieldDelegate {
    
    let searchTextField: UITextField = {
        let textF = UITextField()
        textF.backgroundColor = .white
        textF.placeholder = "Search movies"
        textF.size(height:40)
        textF.layer.borderColor = UIColor.lightGray.cgColor
        textF.layer.borderWidth = 1
        textF.layer.cornerRadius = 4
        textF.setLeftPaddingPoints(10)
        textF.setRightPaddingPoints(10)
        return textF
    }()
 
    let mainView: UIView = {
        let main  = UIView()
        main.backgroundColor = .white
        main.layer.cornerRadius = 4
        return main
    }()
    
    var onButtonTapped: (() -> Void)?
    var stackView : UIStackView?
    
    var payBillBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI(){
        addSubview(mainView)
        mainView.fitToSuper()
        stackView = mainView.HStack(spacing: 16,alignment: .leading)
        stackView?.fitToSuper(insets: .init(top: 0, left: 0, bottom: 0, right: 0))
        stackView?.padding([.left,.right], amount: 0)

        stackView?.addArrangedSubview(searchTextField)
        
    }
    
    @objc func handleBtnTapped(){
        Log.info()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
