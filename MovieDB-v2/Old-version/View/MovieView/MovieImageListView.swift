//
//  MovieImageListCell.swift
//  MovieDB-v2
//
//  Created by Imran on 29/8/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit
import SDWebImage

class MovieImageListCell: UITableViewCell, Reusable {
    
    var vedioImageList = [Backdrop]()
    var imageCount = 0
    var changeImageStatus = 0
    var storeImage = [Any]()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    init(vedioImageList: [Backdrop]?) {
        super.init(style: .default, reuseIdentifier: MovieImageListCell.nibName)
        self.vedioImageList = vedioImageList ?? []
        setupUI()
    }
  
    func  setupUI(){
        contentView.addSubview(collectionView)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.isPagingEnabled = true
        collectionView.register(ImageListCollectionCell.self, forCellWithReuseIdentifier: "CELL_ID")
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.fitToSuper(insets: .init(top: 10, left: 15, bottom: 0, right: 0))
        collectionView.size(width:120, height: 120, heightPriority: 250)
        collectionView.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension MovieImageListCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vedioImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL_ID", for: indexPath) as! ImageListCollectionCell
        let index = vedioImageList[indexPath.item]
        
        let imgUrl = URL(string: "\(APIClient.EndPoints.BACKDROP_PATH + index.filePath)")
        cell.imageItem.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "frame-0"), options: .delayPlaceholder, completed: nil)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: collectionView.frame.height)
    }
}

class ImageListCollectionCell: UICollectionViewCell {
    let imageItem = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageItem)
        imageItem.position( left: leadingAnchor, bottom: bottomAnchor, right: trailingAnchor)
        imageItem.size(  dimensionWidth: contentView.widthAnchor, dimensionHeight: contentView.heightAnchor)
        imageItem.backgroundColor = .lightGray
        imageItem.layer.cornerRadius = 8
        imageItem.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
