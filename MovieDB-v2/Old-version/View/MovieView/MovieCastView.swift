//
//  MovieCastView.swift
//  MovieDB-v2
//
//  Created by Imran on 20/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCastView: UIView {
    
    let MOVIECAST_CELL = "CELL"
    
    var movieDetails : MovieDetails?
    var casts = [MovieCast]()
    
    var callback: ((_ id: Int) -> Void)?
    
    
    
    //     let upcommingView = UpcommingMovieView()
    
    var details_ID  : MovieDetailsVC?
    
    var upcommingView : UpcommingMovieView?
    
    var case_id = 0
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .red
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(MovieCastCell.self, forCellWithReuseIdentifier: MOVIECAST_CELL)
        
        addSubview(collectionView)
        collectionView.backgroundColor = .white
        self.collectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init())
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // your code here
            APIClient.getMovieCreditsId(id:GLOBAL_MOVIE_ID) { (response, error) in
                //                 print("id----movie credit id",self.id)
                if let response = response {
                    self.casts = response[0].cast ?? []
                    print("credit =====\(response)")
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
        //   }
        
    }
    
    
    func getAttributtedMsg(title:String?, msg:String?)->NSMutableAttributedString{
          let atrTxt = NSMutableAttributedString(string: "")
          var newLine = ""
          if title != nil {
              let attrTitle: NSMutableAttributedString = getAttributedText(string: title!.uppercased(), font: UIFont(name: appFont, size: 12.dynamic())!, color:UIColor.init(red: 0.05, green: 0.06, blue: 0.015, alpha: 1) , lineSpace: 5, alignment: .center)
              atrTxt.append(attrTitle)
              newLine = "\n"
          }
          if msg != nil {
              let attrValue: NSMutableAttributedString = getAttributedText(string: "\(newLine)\(msg!)", font: UIFont(name: appFont, size: 10.dynamic())!, color: .darkGray, lineSpace: 5, alignment: .center)
              atrTxt.append(attrValue)
          }
          
          //MARK: DELETE NEW LINE:
          while !atrTxt.string.isEmpty && CharacterSet.newlines.contains(atrTxt.string.unicodeScalars.last!) {
              atrTxt.deleteCharacters(in: NSRange(location: atrTxt.length - 1, length: 1))
          }
          
          return atrTxt
      }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension MovieCastView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("countx\(casts.count)----cast")
        return casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = casts[indexPath.item]
        print(selected ?? "")
        
        let callBackId =  selected.id
        
        callback?(callBackId!)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MOVIECAST_CELL, for: indexPath) as! MovieCastCell
//         cell.backgroundColor = .red
        
        let apiResponse = casts[indexPath.item]
        self.case_id = apiResponse.id ?? 0
        print(apiResponse, "apiResponse====")
        if apiResponse.profilePath != nil {
            let img =  URL(string: "\(APIClient.EndPoints.PROFILE_URL + apiResponse.profilePath!)")
            cell.imageView.sd_setImage(with: img, completed: nil)
            
            let originalnName = apiResponse.name
            let movieName = apiResponse.character
            
            cell.titleNowPlayingMovie.attributedText = getAttributtedMsg(title: originalnName, msg: movieName)
        } else {
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 220)
    }
}
