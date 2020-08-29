//
//  UpcommingMovieVC.swift
//  MovieDB-v2
//
//  Created by Imran on 19/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit
import SDWebImage


class UpcommingMovieView: UIView {
    
    private let CELL_ID =  "CELL"
    
    
    
    var movie = [Movie]()
    var app: Movie?
    
    

    private var result = [Result]()
//
//    var didSelectHandler : ((Movie) -> ())?
//        var didSelectCallback: (() -> Void)?
    
    var callback: ((_ id: Int) -> Void)?
    
//    var setData = Int
    //    var
    var global_movie_id :Int = 0
    
   
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //        backgroundColor = .blue
        
        setupCollectionView()
        
//        var global_id = app?.results.
        
        APIClient.getPopularMovieList { (response, error) in
            // print(response)
            
            if let response = response {
                print(response)
                self.movie = response
                self.result = response[0].results ?? []
                GLOBAL_MOVIE_ID = self.result[0].id
                print("MOVIE ID:::\(GLOBAL_MOVIE_ID)")
//                self.global_movie_id = self.movie.
                
            }
            DispatchQueue.main.async {
                
                self.collectionView.reloadData()
            }
        }
        
        //        print("hello up view")
    }
    
    func setupCollectionView(){
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UpcommingCollectionViewCell.self, forCellWithReuseIdentifier: CELL_ID)
        addSubview(collectionView)
        self.collectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        collectionView.backgroundColor = .white
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
    }
    
    override func layoutIfNeeded() {
        backgroundColor = .red
        
        
        print("hello up view")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UpcommingMovieView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ID, for: indexPath) as! UpcommingCollectionViewCell
        // cell.backgroundColor = .red
        cell.layer.cornerRadius = 10
        
        let data = result[indexPath.item]
        
        let imgUrl = URL(string: "\(APIClient.EndPoints.POSTER_URL + data.posterPath!)")
        cell.imageView.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "frame-0"), options: .delayPlaceholder, completed: nil)
        cell.movieTitle.text = data.originalTitle
        
        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let data = result[indexPath.item]
        
        let callBackId =  data.id
        
        callback?(callBackId)
 
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-40, height: collectionView.frame.height)
    }
    
    
    
    
    
    
}
