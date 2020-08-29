//
//  DashboardVC.swift
//  MovieDB-v2
//
//  Created by Imran on 19/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit

var movieID = 0

class DashboardVC: BaseVC {
    
    let upcommingView = UpcommingMovieView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
          isTopbar = false
          resetBase()
        view.backgroundColor = .white
        
        setupMovieUI()
        
        navigationItem.title = "Movie"
        
        print("hello dashboard")
        
        //   setupViews()
        //setupBottomTabBar()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
//        self.navigationItem.setHidesBackButton(false, animated: true);
    }
        func setupMovieUI() {
            print("adib")
            //   setContentHeight(height: 3000)
            
            //   upcommingView.frame = CGRect(x: 10, y: 200, width: 32, height: 400)
            contentView.addSubview(upcommingView)
            
         //   upcommingView.translatesAutoresizingMaskIntoConstraints = false
            upcommingView.anchor(top: contentView.topAnchor,
                                 leading: contentView.leadingAnchor,
                                 bottom: contentView.bottomAnchor,
                                 trailing: contentView.trailingAnchor,
                                 padding: .init(top: 60, left: 10, bottom: 0, right: 10),
                                 size: .init(width: upcommingView.frame.width, height: 180)
            )
            // MARK: // Another Solution
            
            //        upcommingView.didSelectCallback = { [weak self] in
            //            guard let weakSelf = self else {return}
            //            let vc = MovieDetailsVC()
            //            weakSelf.navigationController?.pushViewController(vc, animated: true)
            //
            //            //}
            //        }
            //
            
            // MARK: // Another Solution - PERFECT SOLUTION
            upcommingView.callback = { (id) -> Void in
                print("callback - \(id)")
                // print(id)
                let vc = MovieDetailsVC()
                GLOBAL_MOVIE_ID = id
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
        
        
        func setupViews(){
            contentView.addSubview(label1)
            label1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            label1.topAnchor.constraint(equalTo: upcommingView.bottomAnchor).isActive = true
            label1.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
            
            contentView.addSubview(label2)
            label2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 25).isActive = true
            label2.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
            label2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }
        
        let label1: UILabel = {
            let label = UILabel()
            label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborumLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborumLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.............."
            label.numberOfLines = 0
            label.sizeToFit()
            label.textColor = UIColor.blue
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let label2: UILabel = {
            let label = UILabel()
            label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
            label.numberOfLines = 0
            label.sizeToFit()
            label.textColor = UIColor.green
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
}
