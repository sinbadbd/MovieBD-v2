//
//  SimilarMovieView.swift
//  MovieDB-v2
//
//  Created by Imran on 30/8/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit
import SDWebImage

class SimilarMovieView: UIView {
    
    var result = [Result]()
    var callback: ((_ id: Int) -> Void)?
    
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        getServerData()
    }
    
    func getServerData(){
        APIClient.getMovieSimilarId(id: GLOBAL_MOVIE_ID) { (response, error) in
            if let response = response {
                
                for item in response {
                    print(item.results)
                }
                
//                self.result = response[0].results ?? []
////                DispatchQueue.main.async {
//                    if self.result.count > 0 {
//                        
//                        self.collectionView.reloadData()
//                        self.setupUI()
//                        self.collectionView.isHidden = false
//                    }else {
//                        self.collectionView.isHidden = true
//                    }
////                }
            }
        }
    }
    func setupUI(){
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.isPagingEnabled = true
        collectionView.register(SimilarMovieViewCollectionCell.self, forCellWithReuseIdentifier: "CELL_ID")
        addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        
        let movieImageTitle = UILabel()
        addSubview(movieImageTitle)
        movieImageTitle.anchor(top: topAnchor, leading:  leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 10, bottom: 0, right: 20), size: .init(width: 120, height: .init()))
        
        movieImageTitle.centerXInSuperview()
        
        let attr1: NSMutableAttributedString = getAttributedText(string: "Similar ", font: UIFont(name: appFontBold, size: 18)!, color: .black, lineSpace: 5, alignment: .left)
        
        let attr2: NSMutableAttributedString = getAttributedText(string: "", font: UIFont(name: appFontMedium, size: 18)!, color: .gray, lineSpace: 0, alignment: .left)
        
        attr1.append(attr2)
        movieImageTitle.attributedText = attr1
        movieImageTitle.numberOfLines = 0
        
        collectionView.position(top: movieImageTitle.bottomAnchor, left: leadingAnchor, bottom: bottomAnchor, right: leadingAnchor, insets: .init(top: 20, left: 0, bottom: 0, right: 0))
        collectionView.size( dimensionWidth: widthAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension SimilarMovieView:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL_ID", for: indexPath) as! SimilarMovieViewCollectionCell
        cell.backgroundColor = .clear
        
        let index = result[indexPath.item]
        
        
        let imgUrl = URL(string: "\(APIClient.EndPoints.BACKDROP_PATH + index.posterPath!)")
        cell.imageView.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "frame-0"), options: .delayPlaceholder, completed: nil)
        cell.titleLbl.text = index.originalTitle
        
        
        
        return cell 
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = result[indexPath.item]
        let callBackId =  data.id
        
        callback?(callBackId)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: collectionView.frame.height)
    }
}

class SimilarMovieViewCollectionCell: UICollectionViewCell {
    let imageView = UIImageView()
    let titleLbl  = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(titleLbl)
        
        imageView.position(top: topAnchor, left: leadingAnchor, bottom: nil,right: trailingAnchor,insets: .init(top: 0, left: 0, bottom: 0, right: 0))
        imageView.size( height:150)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        
        
        titleLbl.position(top: imageView.bottomAnchor, left: leadingAnchor, bottom: bottomAnchor, right: trailingAnchor , insets: .init(top: 10, left: 10, bottom: 10, right: 10))
        titleLbl.font = UIFont(name: appFont, size: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
