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
    var type: MovieUrlPath?
    let titleBar = TitleBarView()
    
    public init(color: UIColor?, title: String?, seeAll: String?){
        super.init(style: .default, reuseIdentifier: TitleBarTableCell.nibName)
        backgroundColor = .clear
        selectionStyle = .none
        setupUI()
        getCell(color: color ?? .gray, title: title ?? "", seeAll: seeAll ?? "")
        Log.info()
    }
    
    public required init?(coder: NSCoder) { super.init(coder: coder) }
    
    func setupUI(){
        setupStact()
        addToStack()
    }
    func setupStact(){
        stackView = contentView.VStack(spacing: 0)
        stackView?.fitToSuper(insets: .init(top: 0, left: 20, bottom:0, right: 20))
    }
    
    func addToStack(){
        stackView?.addArrangedSubview(titleBar)
    }
    
    func getCell(color: UIColor, title: String, seeAll: String) {
        titleBar.getTitleInfo(color: color, title: title , seeAll: seeAll)
    }
}
