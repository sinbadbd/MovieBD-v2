//
//  ArtistMovieList.swift
//  MovieDB-v2
//
//  Created by Imran on 20/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//


import UIKit
import SDWebImage
class ArtistMovieView : UIView{
    
    let ARTIST_MOVIE_LIST = "MOVIELIST"
    
    var casts = [Cast]()
    
    private let colletionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
      var callback: ((_ id: Int) -> Void)?
    
    var id : Int! {
        didSet {
            print("id", id)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       backgroundColor = #colorLiteral(red: 0.2033947077, green: 0.2201191104, blue: 0.2415348346, alpha: 1)
        
        addSubview(colletionView)
        colletionView.register(artistMovieCell.self, forCellWithReuseIdentifier: ARTIST_MOVIE_LIST)
        colletionView.dataSource = self
        colletionView.delegate = self
        colletionView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 10, bottom: 10, right: 0), size: CGSize(width: colletionView.frame.width, height: 250))
        colletionView.backgroundColor = #colorLiteral(red: 0.2033947077, green: 0.2201191104, blue: 0.2415348346, alpha: 1)
        colletionView.showsHorizontalScrollIndicator = false
        
        APIClient.getPersonMovieCreditsId(id: PERSON_ID) { (response, error) in
            if let response = response {
                self.casts = response[0].cast ?? []
                DispatchQueue.main.async {
                    self.colletionView.reloadData()
                }
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArtistMovieView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(casts.count)
        return casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ARTIST_MOVIE_LIST, for: indexPath) as! artistMovieCell
        let apiData = casts[indexPath.item]
        print(apiData)
        if apiData.backdropPath != nil {
            let img =  URL(string: "\(APIClient.EndPoints.PROFILE_URL + apiData.backdropPath!)")
            cell.artistMovieImage.sd_setImage(with: img, completed: nil)
        } else {
            
        }
        
        cell.artistMovieTitle.text = apiData.originalTitle
        
        cell.backgroundColor = #colorLiteral(red: 0.250479877, green: 0.2711839974, blue: 0.2981133461, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = casts[indexPath.item]

        let callBackId =  selected.id
        
        print("\(selected) - \(callBackId)")
        callback?(callBackId!)
    }

}

class artistMovieCell : UICollectionViewCell {
    
    let artistMovieImage : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let artistMovieTitle = MyUILabel(frame: .zero, text: "tes", textColor: .white, fontSize: UIFont.systemFont(ofSize: 14), textAlign: .left)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(artistMovieImage)
        artistMovieImage.translatesAutoresizingMaskIntoConstraints = false
        artistMovieImage.backgroundColor = .gray
        artistMovieImage.layer.shadowColor = UIColor.black.cgColor
        artistMovieImage.layer.shadowOffset = CGSize(width: 3, height: 3)
        artistMovieImage.layer.shadowOpacity = 0.7
        artistMovieImage.layer.shadowRadius = 5.0
        artistMovieImage.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: CGSize(width: 140, height: 210))
        
        addSubview(artistMovieTitle)
        artistMovieTitle.anchor(top: artistMovieImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        artistMovieTitle.numberOfLines = 3
        artistMovieTitle.textColor = .white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

