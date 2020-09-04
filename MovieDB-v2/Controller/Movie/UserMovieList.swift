//
//  UserMovieList.swift
//  MovieDB-v2
//
//  Created by Imran on 3/9/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit
class UserMovieList: UIViewController {
    
       let collectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
         return collection
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  isShowBottomTab = false
        //resetBase()
      
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.register(UserMovieListCell.self, forCellWithReuseIdentifier: "cellx")
//        view.addSubview(collectionView)
//
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
            collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: collectionView.frame.width, height: collectionView.frame.height))
          collectionView.backgroundColor = .white
//      /  setCollectionLayout()
//        collectionView.size(  dimensionWidth: view.widthAnchor )
        
        // MARK: ENABLE FOR : BASEVC
//        let mainView = UIView()
//        contentView.addSubview(mainView)
//        mainView.position(top: contentView.topAnchor, left: contentView.leadingAnchor, bottom: contentView.bottomAnchor, right: contentView.trailingAnchor, insets: .init(top: 10, left: 10, bottom: 20, right: 10))
////        mainView.size(  dimensionHeight: contentView.heightAnchor)
//
//        mainView.addSubview(collectionView)
//        mainView.backgroundColor = .black
//        collectionView.position(top: mainView.topAnchor, bottom: mainView.bottomAnchor)
//        collectionView.size(  dimensionWidth: mainView.widthAnchor, dimensionHeight: mainView.heightAnchor )
    }
    
    func setCollectionLayout() {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:0,left:0,bottom:0,right:0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/2 - 1, height: 136)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView.collectionViewLayout = layout
    }
}
extension UserMovieList: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellx", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width/2-40, height: 200)
//      }
      
//      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//          return UIEdgeInsets(top: 20, left: 10, bottom: 50, right: 10)
//      }
    
    
}


class UserMovieListCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
