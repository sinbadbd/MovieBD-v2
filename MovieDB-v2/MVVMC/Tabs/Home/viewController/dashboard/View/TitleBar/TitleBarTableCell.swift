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
    
    public init(type: MovieUrlPath?){
        super.init(style: .default, reuseIdentifier: TitleBarTableCell.nibName)
        backgroundColor = .clear
        selectionStyle = .none
        self.type = type ?? .upcoming
        setupUI()
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
        let titleBar = TitleBarView()
        stackView?.addArrangedSubview(titleBar)
        
        if type == .upcoming {
            Log.info()
            titleBar.getTitleInfo(color: .red, title: "Upcomming Movies sf", seeAll: "See All")
        }else if type == .nowPlaying {
            Log.info()
            titleBar.getTitleInfo(color: .red, title: "Now Playing Movies", seeAll: "See All")

        }else if type == .popular {
            Log.info()
            titleBar.getTitleInfo(color: .red, title: "Popular Movies", seeAll: "See All")

        } else if type == .topRated {
            Log.info()
            titleBar.getTitleInfo(color: .red, title: "TopRated Movies", seeAll: "See All")
        }
    }
 
}
