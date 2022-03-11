//
//  MovieVedioList.swift
//  MovieDB-v2
//
//  Created by Imran on 29/8/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit
import YouTubePlayer

class MovieVedioListViewCell: UITableViewCell, Reusable {
    
    var videoPlayer = YouTubePlayerView()
    var vedioList = [VideoResult]()
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    
    init(vedioList: [VideoResult]){
        super.init(style: .default, reuseIdentifier: MovieCollectionCell.nibName)
        self.vedioList = vedioList
        setupUI()
    }
 
 
    func  setupUI(){
        contentView.addSubview(collectionView)

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.isPagingEnabled = true
        collectionView.register(VedioListCollectionCell.self, forCellWithReuseIdentifier: "CELL_ID")
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.fitToSuper(insets: .init(top: 0, left: 15, bottom: 0, right: 0))
        collectionView.size( width:200, height: 220, heightPriority: 250)
        collectionView.reloadData()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieVedioListViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vedioList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL_ID", for: indexPath) as! VedioListCollectionCell

        let index = vedioList[indexPath.item]
        
        cell.key = index.key ?? ""
        cell.title.text = index.name ?? ""
        cell.videoPlayer?.loadVideoID(cell.key)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = vedioList[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL_ID", for: indexPath) as! VedioListCollectionCell
        
        cell.videoPlayer?.loadVideoID(index.key ?? "")

    }
}

class VedioListCollectionCell: UICollectionViewCell {
    
    let videoView = UIView()
    let title     = UILabel()
    
    var key = ""

    var videoPlayer : YouTubePlayerView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
 
    func setupUI(){
    
        addSubview(videoView)
        
        videoView.position(top: topAnchor, left: leadingAnchor, bottom: nil, right: trailingAnchor)
        
        videoPlayer = YouTubePlayerView()
        videoPlayer?.frame = CGRect(x: 0, y: 0, width: 250, height: 140)
        videoView.addSubview(videoPlayer!)
        videoView.size( height: 140)
        videoView.backgroundColor = .lightGray
 
        addSubview(title)
        title.position(top: videoView.bottomAnchor, left: leadingAnchor, bottom: bottomAnchor, right: trailingAnchor, insets: .init(top: 5, left: 15, bottom: 10, right: 10))
        title.text = ""
        title.font = UIFont(name: appFont, size: 16)
        title.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
