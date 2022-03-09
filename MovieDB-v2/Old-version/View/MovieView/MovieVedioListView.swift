//
//  MovieVedioList.swift
//  MovieDB-v2
//
//  Created by Imran on 29/8/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit
import YouTubePlayer

class MovieVedioListView: UIView {
    
    var videoPlayer = YouTubePlayerView()
    var vedioList = [VideoResult]()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    var videoList_Id = ""
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        getServerData()
        setupUI()
    }
    
    func getServerData(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // your code here
            APIClient.getMovieVideoId(id:GLOBAL_MOVIE_ID) { (response, error) in
                if let response = response {
                    print("VEDIO LIST: \(response)")
                    self.vedioList = response[0].results ?? []
                    totalVedioCount = self.vedioList.count
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    func  setupUI(){
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.isPagingEnabled = true
        collectionView.register(VedioListCollectionCell.self, forCellWithReuseIdentifier: "CELL_ID")
        addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.position(top: topAnchor, left: leadingAnchor, bottom: bottomAnchor, right: leadingAnchor)
        collectionView.size( dimensionWidth: widthAnchor, dimensionHeight: heightAnchor)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieVedioListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vedioList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL_ID", for: indexPath) as! VedioListCollectionCell
        //        cell.backgroundColor = .red
        
        let index = vedioList[indexPath.item]
        
        cell.key = index.key ?? ""
        cell.title.text = index.name ?? ""
        cell.videoPlayer?.loadVideoID(cell.key)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: collectionView.frame.height)
    }
    
}

class VedioListCollectionCell: UICollectionViewCell {
    
    let videoView = UIView()
    let title     = UILabel()
    
    var key = ""
    
    //
    
    //    let videoPlayer = YouTubePlayerView(frame: .init())
    var videoPlayer : YouTubePlayerView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    //     let videoPlayer = YouTubePlayerView(frame: CGRect(x: 0, y: 0, width: 250, height: 140))
    
    func setupUI(){
        
        //       for view in self.subviews {
        //            view.removeFromSuperview()
        //        }
        
        
        addSubview(videoView)
        
        videoView.position(top: topAnchor, left: leadingAnchor, bottom: nil, right: trailingAnchor)
        
        videoPlayer = YouTubePlayerView()
        videoPlayer?.frame = CGRect(x: 0, y: 0, width: 250, height: 140)
        videoView.addSubview(videoPlayer!)
        videoView.size( height: 140, dimensionWidth: contentView.widthAnchor)
        videoView.backgroundColor = .blue
        //        videoPlayer.loadVideoID(key)
        
        //        videoPlayer.loadVideoID(key)
        
        addSubview(title)
        title.position(top: videoView.bottomAnchor, left: leadingAnchor, bottom: bottomAnchor, right: trailingAnchor, insets: .init(top: 10, left: 15, bottom: 10, right: 10))
        title.text = ""
        title.font = UIFont(name: appFont, size: 16)
        title.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
