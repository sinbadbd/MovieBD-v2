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
    
    let collectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .horizontal
          let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
          return collection
      }()
      
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        getServerData()
        setupUI()
    }
    
      func getServerData(){
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              // your code here
              APIClient.getMovieImageId(id:GLOBAL_MOVIE_ID) { (response, error) in
                  if let response = response {
                      print("Image LIST: \(response)")
                    self.vedioImageList = response[0].backdrops ?? []
                    totalImageCount = self.vedioImageList.count
                      
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
          collectionView.register(ImageListCollectionCell.self, forCellWithReuseIdentifier: "CELL_ID")
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
extension MovieImageListView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vedioImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL_ID", for: indexPath) as! ImageListCollectionCell
 
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
          (imageItem).position(top: topAnchor, left: leadingAnchor, bottom: bottomAnchor, right: trailingAnchor)
        imageItem.size(  dimensionWidth: contentView.widthAnchor, dimensionHeight: contentView.heightAnchor)
        imageItem.backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
