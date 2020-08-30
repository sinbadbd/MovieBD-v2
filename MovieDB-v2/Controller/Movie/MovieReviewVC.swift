//
//  MovieReviewVC.swift
//  MovieDB-v2
//
//  Created by Imran on 30/8/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit

class MovieReviewVC: UIViewController {
    
    var tableView = UITableView()
    
    var page: Int = 0
    var totalPages: Int = 0
    
    var review = [MovieResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        resetBase()
        view.backgroundColor = .white
        
        getServerData(page)
    }
    
    func getServerData(_ page: Int){
        APIClient.getMovieReviewId(page: page, id: 299536) { (response, error) in
            if let response = response {
                self.page = response[0].page
                self.totalPages = response[0].totalPages
                
//                if self.page < self.totalPages {
                   
                    print("page-count: \(self.page)")
                    self.review = response[0].results ?? []
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.setupReviewUI()
                    }
//                }
                
                
            }
            
            
        }
    }
    
    func setPagination(_ page: Int){
        if self.page < self.totalPages {
             self.page += 1
        }
    }
    
    func setupReviewUI(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(MovieReviewTabelCell.self, forCellReuseIdentifier: "cell_id" )
        
        view.addSubview(tableView)
        tableView.position(top: view.topAnchor, left: view.leadingAnchor, bottom: view.bottomAnchor   , right: view.trailingAnchor)
        //        tableView.size(dimensionWidth: contentView.widthAnchor, dimensionHeight: contentView.heightAnchor)
        //        tableView.backgroundColor = .red
        tableView.backgroundColor = .white
        //               tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000
          
    }
}

extension MovieReviewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return review.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_id", for: indexPath) as! MovieReviewTabelCell
        cell.backgroundColor = .clear
        let index = review[indexPath.row]
        
        
        let attr1: NSMutableAttributedString = getAttributedText(string: "\(index.content)\n\n", font: UIFont(name: appFont, size: 14)!, color: .black, lineSpace: 5, alignment: .left)
              
        let attr2: NSMutableAttributedString = getAttributedText(string: "Author: \(index.author)", font: UIFont(name: appFontMedium, size: 16)!, color: .gray, lineSpace: 0, alignment: .left)
              
              attr1.append(attr2)
        cell.titleLbl.attributedText = attr1
            cell.titleLbl.numberOfLines = 0
        
        
//        cell.textLabel?.text = index.author
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
          let count = review.count - 1
//        let lastItem = self.count - 1
//        if indexPath.row == count {
//            print("IndexRow\(indexPath.row)")
//
//
//            if self.page < self.totalPages {
//                self.page += 1
//               //Get data from Server
//                self.getServerData(page)
//
//            }
//        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 140
//    }
    // UITableViewAutomaticDimension calculates height of label contents/text
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class MovieReviewTabelCell: UITableViewCell {
    
    let titleLbl = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layoutMargins = UIEdgeInsets.zero //or UIEdgeInsetsMake(top, left, bottom, right)
        self.separatorInset = UIEdgeInsets.zero
        
        addSubview(titleLbl)
        titleLbl.position(top: topAnchor, left: leadingAnchor, bottom: bottomAnchor, right: trailingAnchor, insets: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
