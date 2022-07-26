//
//  MovieCollectionView.swift
//  MovieDB-v2
//
//  Created by Imran on 9/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit
 
protocol MovieDetilsProtocol: AnyObject {
    func setIndexPath(item: Result)
}

class MovieCollectionTableCell: UITableViewCell, Reusable {
    
    
    weak var delegate: MovieDetilsProtocol?
    
    var movie: [Result]?
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    public init(movie: [Result], delegate: MovieDetilsProtocol?){
        super.init(style: .default, reuseIdentifier: MovieCollectionTableCell.nibName)
        self.movie = movie
        self.delegate = delegate 
        setupUI()
    }
    
    func setupUI(){
        addSubview(contentView)
        contentView.fitToSuper()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        collectionView.fitToSuper(insets: .init(top: 0, left: 20, bottom: 0, right: 0))
        collectionView.size( height: 260,  heightPriority: 250)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier: MovieCollectionCell.nibName)
        shadowForViewLight(shadow: collectionView)
        collectionView.reloadData()
        
    }
    
    required init?(coder: NSCoder) {   fatalError("init(coder:) has not been implemented")   }
    
}

extension MovieCollectionTableCell {
    func getMovieData(){
        
    }
}

extension MovieCollectionTableCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.nibName, for: indexPath) as! MovieCollectionCell
        let data = movie?[indexPath.item]
        let img =  URL(string: "\(APIClient.EndPoints.BACKDROP_PATH + (data?.backdropPath ?? ""))")
        cell.configureCell(poster: img, rating: data?.voteAverage, title: data?.title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.frame.height-10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = movie?[indexPath.item] else { return  }
        delegate?.setIndexPath(item: data)
        Log.debug(data)
    }
}
