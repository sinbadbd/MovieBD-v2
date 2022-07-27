//
//  DashboardVC.swift
//  MovieDB-v2
//
//  Created by Imran on 19/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit

class DashboardVC: BaseVC {
    
    let upcommingView     = UpcommingMovieView()
    let discoverMovieView = DiscoverMovieView()
    let popularMovieView  = PopularMovieView()
    let topRatedMovie     = TopRatingMovieView()
    
    
      var bottomView : BottomTabView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        isTopbar = false
        // isShowBottomTab = false
        resetBase()
   
        view.backgroundColor = .white
        setupBottomTabBar()
        setupMovieUI()
      
        callbackRedirection()
        navigationItem.title = "Movie"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
           
    }
    
    
    
    func setupMovieUI() {
        
        let upcommingMovieTitle = UILabel()
        contentView.addSubview(upcommingMovieTitle)
        upcommingMovieTitle.position(top: contentView.topAnchor ,left:contentView.leadingAnchor,right:contentView.trailingAnchor,insets: .init(top: 60, left: 15, bottom: 0, right: 10))
        //        upcommingMovieTitle.size( dimensionWidth: contentView.widthAnchor)
        upcommingMovieTitle.text = "Upcomming Movie".uppercased()
        upcommingMovieTitle.font = UIFont(name: appFontBold, size: 16)
        
        contentView.addSubview(upcommingView)
        upcommingView.anchor(top: upcommingMovieTitle.bottomAnchor,
                             leading: contentView.leadingAnchor,
                             bottom:nil,
                             trailing: contentView.trailingAnchor,
                             padding: .init(top: 5, left: 10, bottom: 0, right: 10),
                             size: .init(width: upcommingView.frame.width, height: 180)
        )
        
        
        let discoverMovieTitle = UILabel()
        contentView.addSubview(discoverMovieTitle)
        discoverMovieTitle.position(top: upcommingView.bottomAnchor ,left:contentView.leadingAnchor,right:contentView.trailingAnchor,insets: .init(top: 15, left: 15, bottom: 0, right: 10))
        //        upcommingMovieTitle.size( dimensionWidth: contentView.widthAnchor)
        discoverMovieTitle.text = "Dicover Movie".uppercased()
        discoverMovieTitle.font = UIFont(name: appFontBold, size: 16)
        
        contentView.addSubview(discoverMovieView)
        discoverMovieView.anchor(top: discoverMovieTitle.bottomAnchor,
                                 leading: contentView.leadingAnchor,
                                 bottom:nil,
                                 trailing: contentView.trailingAnchor,
                                 padding: .init(top: 5, left: 10, bottom: 0, right: 10),
                                 size: .init(width: discoverMovieView.frame.width, height: 180)
        )
        
        
        let popularMovieTitle = UILabel()
        contentView.addSubview(popularMovieTitle)
        popularMovieTitle.position(top: discoverMovieView.bottomAnchor ,left:contentView.leadingAnchor,right:contentView.trailingAnchor,insets: .init(top: 15, left: 15, bottom: 0, right: 10))
        //        upcommingMovieTitle.size( dimensionWidth: contentView.widthAnchor)
        popularMovieTitle.text = "Popular Movie".uppercased()
        popularMovieTitle.font = UIFont(name: appFontBold, size: 16)
        
        contentView.addSubview(popularMovieView)
        popularMovieView.anchor(top: popularMovieTitle.bottomAnchor,
                                leading: contentView.leadingAnchor,
                                bottom:nil,
                                trailing: contentView.trailingAnchor,
                                padding: .init(top: 5, left: 10, bottom: 0, right: 10),
                                size: .init(width: popularMovieView.frame.width, height: 180)
        )
        
        let topRatedMovieTitle = UILabel()
              contentView.addSubview(topRatedMovieTitle)
              topRatedMovieTitle.position(top: popularMovieView.bottomAnchor ,left:contentView.leadingAnchor,right:contentView.trailingAnchor,insets: .init(top: 15, left: 15, bottom: 0, right: 10))
              //        upcommingMovieTitle.size( dimensionWidth: contentView.widthAnchor)
              topRatedMovieTitle.text = "Top Rated Movie".uppercased()
              topRatedMovieTitle.font = UIFont(name: appFontBold, size: 16)


        contentView.addSubview(topRatedMovie)
        topRatedMovie.anchor(top: topRatedMovieTitle.bottomAnchor,
                             leading: contentView.leadingAnchor,
                             bottom:contentView.bottomAnchor,
                             trailing: contentView.trailingAnchor,
                             padding: .init(top: 5, left: 10, bottom: 60, right: 10),
                             size: .init(width: topRatedMovie.frame.width, height: 180)
        )
        
    }
    
    
    
    func  callbackRedirection(){
        // MARK: // Another Solution - PERFECT SOLUTION
        upcommingView.callback = { (id) -> Void in
            print("callback - \(id)")
            // print(id)
            let vc = MovieDetailsVC()
            GLOBAL_MOVIE_ID = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        discoverMovieView.callback = { (id) -> Void in
            print("callback - \(id)")
            // print(id)
            let vc = MovieDetailsVC()
            GLOBAL_MOVIE_ID = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
        popularMovieView.callback = { (id) -> Void in
            print("callback - \(id)")
            // print(id)
            let vc = MovieDetailsVC()
            GLOBAL_MOVIE_ID = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
        topRatedMovie.callback = { (id) -> Void in
            print("callback - \(id)")
            // print(id)
            let vc = MovieDetailsVC()
            GLOBAL_MOVIE_ID = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
  
    
    func setupBottomTabBar(){
           bottomView = BottomTabView()
           bottomView?.delegate = self
           contentView.addSubview(bottomView!)
           bottomView?.position( bottom: view.bottomAnchor, right: nil, insets: .init(top: 0, left: 0, bottom: 0, right: 0))
           bottomView?.size(wAnchor: nil, hAnchor: nil,  height: 70, dimensionWidth: contentView.widthAnchor)
           bottomView?.layer.zPosition = 999999
           bottomView?.bringSubviewToFront(contentView)
        bottomView!.layer.zPosition = .greatestFiniteMagnitude

        }
}
extension BaseVC: BottomViewProtocol {
    func profileBtn(sender: UIButton) {
        let vc = ProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
