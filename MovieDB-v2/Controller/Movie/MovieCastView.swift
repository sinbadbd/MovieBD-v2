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
        // MOVIE CREDITS API CALL
        //movieCredit
        //   if id != nil {
        
//        APIClient.getMovieId(id: <#T##Int#>, completion: <#T##(MovieDetails?, Error?) -> Void#>)
        
//        guard let id = self.movieDetails?.id else {return}
        
        
//        let id = details_ID.movie_id
//        print("id-****\(id)")
        
//       upcommingView.callback = { (id) -> Void in
//        print("imran")
//            print("callback - \(id)")
//        print("vc.movie_id \(String(describing: id))")
//        }
//
        
//        print("cast_id\(destaisl.id)")
//        guard let id = movieDetails?.id else {return}
//        guard let id = details_ID?.movie_id else {return}
        
        let id = upcommingView?.app?.results
        print("movie_id\(id)")
        APIClient.getMovieCreditsId(id:278) { (response, error) in
            //                 print("id----movie credit id",self.id)
            if let response = response {
                self.casts = response[0].cast ?? []
                print("credit =====\(response)")
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        //   }
        
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
//                let details = ArtistProfileVC()
//                details.artistId = selected.id
//             print( details.artistId ?? "")
        
        
//       navController.pushViewController(details, animated:  true)
//               self.present(details, animated: true, completion: nil)
//                print(details.artistId)
        
        
        //        let vc = ProfileVC()
          //     (superview?.next as? UIViewController)?.navigationController?.pushViewController(details, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MOVIECAST_CELL, for: indexPath) as! MovieCastCell
       // cell.backgroundColor = .black
        
        let apiResponse = casts[indexPath.item]
        print(apiResponse, "apiResponse====")
        if apiResponse.profilePath != nil {
            let img =  URL(string: "\(APIClient.EndPoints.PROFILE_URL + apiResponse.profilePath!)")
            cell.imageView.sd_setImage(with: img, completed: nil)
            cell.titleNowPlayingMovie.text = apiResponse.name
            
            
        } else {
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 140)
    }
}
