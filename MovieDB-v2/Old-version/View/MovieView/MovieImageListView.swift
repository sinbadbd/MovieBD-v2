//
//  MovieImageListView.swift
//  MovieDB-v2
//
//  Created by Imran on 29/8/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit
import SDWebImage

class MovieImageListView: UIView {
    
    
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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        getServerData()
    }
    
    func getServerData(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // your code here
            APIClient.getMovieImageId(id:GLOBAL_MOVIE_ID) { (response, error) in
                if let response = response {
                    print("Image LIST: \(response)")
                    if self.changeImageStatus == 0 {
                       self.vedioImageList = response[0].backdrops ?? []
                         self.imageCount = self.vedioImageList.count
                    }else {
                        self.vedioImageList = response[0].posters ?? []
                         self.imageCount = self.vedioImageList.count
                    }
                    
                   
                    print("self.imageCount \(self.imageCount)")
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.setupUI()
                    }
                }
                
                
            }
        }
    }
    
    
    func  setupUI(){
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.isPagingEnabled = true
        collectionView.register(ImageListCollectionCell.self, forCellWithReuseIdentifier: "CELL_ID")
        addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        
        
        let movieImageTitle = UILabel()
        addSubview(movieImageTitle)
        movieImageTitle.anchor(top: topAnchor, leading:  leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 10, bottom: 0, right: 20), size: .init(width: 120, height: .init()))
        
        movieImageTitle.centerXInSuperview()
        
        let attr1: NSMutableAttributedString = getAttributedText(string: "Images ", font: UIFont(name: appFontBold, size: 18)!, color: .black, lineSpace: 5, alignment: .left)
        
        let attr2: NSMutableAttributedString = getAttributedText(string: " \(imageCount)", font: UIFont(name: appFontMedium, size: 18)!, color: .gray, lineSpace: 0, alignment: .left)
        
        attr1.append(attr2)
        movieImageTitle.attributedText = attr1
        movieImageTitle.numberOfLines = 0
        
        
        
        let segmentItems = ["Backdrops", "Posters"]
        let control = UISegmentedControl(items: segmentItems)
        addSubview(control)
         control.position(top: topAnchor, right: trailingAnchor, insets: .init(top: 15, left: 0, bottom: 0, right: 20))
        control.size( width: 150, height: 30)
        control.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
        control.selectedSegmentIndex = 1
        
        
        
        
        collectionView.position(top: movieImageTitle.bottomAnchor, left: leadingAnchor, bottom: bottomAnchor, right: leadingAnchor, insets: .init(top: 20, left: 0, bottom: 0, right: 0))
        collectionView.size( dimensionWidth: widthAnchor)
        
    }
    
 
    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            print(segmentedControl.selectedSegmentIndex)
//            self.changeImageStatus = 0
//            print(self.vedioImageList.count)
//            self.collectionView.reloadData()
            // First segment tapped
            break
        case 1:
//            self.changeImageStatus = 1
//             
//            self.collectionView.reloadData()
//              print(segmentedControl.selectedSegmentIndex)
            // Second segment tapped
            break
        default:
            break
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension MovieImageListView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if changeImageStatus == 0 {
            return vedioImageList.count
        }else {
            return vedioImageList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL_ID", for: indexPath) as! ImageListCollectionCell
        //        cell.backgroundColor = .red
        let index = vedioImageList[indexPath.item]
        
        let imgUrl = URL(string: "\(APIClient.EndPoints.BACKDROP_PATH + index.filePath)")
        cell.imageItem.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "frame-0"), options: .delayPlaceholder, completed: nil)
        
        // file_path
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
        //        imageItem.layer.maskedCorners = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
