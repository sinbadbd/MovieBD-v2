//
//  ActorMovieCreditsCell.swift
//  MovieDB-v2
//
//  Created by Imran on 12/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import Foundation
import UIKit

protocol ActorMovieCastProtocol: AnyObject {
    func setIndexPath(item: Cast)
}

class ActorMovieCreditsCell: UITableViewCell, Reusable {
    
    weak var delegate: ActorMovieCastProtocol?
    
    var actorMovieCredit: [Cast]?//[PersonMovieCredit]?
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    public init(actorMovieCredit: [Cast]?, delegate: ActorMovieCastProtocol?){
        super.init(style: .default, reuseIdentifier: MoviesCastTableCell.nibName)
        self.actorMovieCredit = actorMovieCredit
        self.delegate = delegate
        setupUI()
    }
    
    func setupUI(){
        addSubview(contentView)
        contentView.fitToSuper()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        collectionView.fitToSuper(insets: .init(top: 0, left: 20, bottom: 0, right: 0))
        collectionView.size( height: 200,  heightPriority: 250)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MoviesCastCollectionCell.self, forCellWithReuseIdentifier: MoviesCastCollectionCell.nibName)
        shadowForViewLight(shadow: collectionView)
        collectionView.reloadData()
        
    }
    
    required init?(coder: NSCoder) {   fatalError("init(coder:) has not been implemented")   }
    
}

extension ActorMovieCreditsCell {
    func getMovieData(){
        
    }
}

extension ActorMovieCreditsCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actorMovieCredit?.count ?? 0//movie?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: MoviesCastCollectionCell.nibName, for: indexPath) as! MoviesCastCollectionCell
        let data = actorMovieCredit?[indexPath.item]
        let img =  URL(string: "\(APIClient.EndPoints.POSTER_URL + (data?.posterPath ?? ""))")
        cell.configureCell(poster: img, title: data?.character)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.height-10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = actorMovieCredit?[indexPath.item] else { return  }
        Log.debug("data: \(data)")
        delegate?.setIndexPath(item: data)
    }
}
