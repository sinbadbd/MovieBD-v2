//
//  MovieCollectionView.swift
//  MovieDB-v2
//
//  Created by Imran on 9/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

class MovieCollectionView {
    
}

class MovieCollectionTableCell: UITableViewCell, Reusable {
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    public init(){
        super.init(style: .default, reuseIdentifier: MovieCollectionTableCell.nibName)
        setupUI()
    }
    
    func setupUI(){
        addSubview(contentView)
        contentView.fitToSuper()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        collectionView.fitToSuper(insets: .init(top: 0, left: 20, bottom: 0, right: 0))
        //        collectionView.updateHeight(constant: 200)
        collectionView.size( height: 250,  heightPriority: 250)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier: MovieCollectionCell.nibName)
        shadowForViewLight(shadow: collectionView)
    }
    
    
    required init?(coder: NSCoder) {   fatalError("init(coder:) has not been implemented")   }
    
}

extension MovieCollectionTableCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.nibName, for: indexPath) as! MovieCollectionCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
