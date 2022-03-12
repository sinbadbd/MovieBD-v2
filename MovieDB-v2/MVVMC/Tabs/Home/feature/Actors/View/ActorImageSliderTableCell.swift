//
//  ActorImageSliderTableCell.swift
//  MovieDB-v2
//
//  Created by Imran on 11/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit
import SDWebImage

class ActorImageSliderTableCell: UITableViewCell, Reusable {
    
   // weak var delegate: MovieCastProtocol?
    
    var profileImg: [ProfileElement]?
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    public init(profileImg: [ProfileElement]){//cast: [MovieCast]?, delegate: MovieCastProtocol?
        super.init(style: .default, reuseIdentifier: ActorImageSliderTableCell.nibName)
//        self.cast = cast
        self.profileImg = profileImg
        setupUI()
    }
    
    func setupUI(){
        addSubview(contentView)
        contentView.fitToSuper()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        collectionView.fitToSuper(insets: .init(top: 0, left: 0, bottom: 0, right: 0))
        collectionView.size( height: 200,  heightPriority: 250)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ActorImageCollectionCell.self, forCellWithReuseIdentifier: ActorImageCollectionCell.nibName)
//        shadowForViewLight(shadow: collectionView)
        collectionView.reloadData()
        
    }
    
    required init?(coder: NSCoder) {   fatalError("init(coder:) has not been implemented")   }
    
}

extension ActorImageSliderTableCell {
    func getMovieData(){
        
    }
}

extension ActorImageSliderTableCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileImg?.count ?? 0//cast?.count ?? 0//movie?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: ActorImageCollectionCell.nibName, for: indexPath) as! ActorImageCollectionCell
        
//        if indexPath.item % 2 == 0 {
//            cell.imageSlider.backgroundColor = .red
//        }else{
//            cell.imageSlider.backgroundColor = .yellow
//
//        }
        
        let data = profileImg?[indexPath.item]
        let img =  URL(string: "\(APIClient.EndPoints.BACKDROP_PATH + (data?.filePath ?? ""))")
        
        cell.configureCell(poster: img)

            
        //resizeImage(image: cell.imageSlider.image ?? "", newWidth: CGSize(width: data?.width ?? 0, height: data?.height ?? 0))
//        cell.configureCell(poster: img, title: data?.character)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      //  guard let data = cast?[indexPath.item] else { return  }
       // delegate?.setIndexPath(item: data)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class ActorImageCollectionCell: UICollectionViewCell, Reusable {
    
    var stackView : UIStackView?
    var imageSlider = ScaledHeightImageView()
    let titleLbl = UILabel()
    
    var proImg: ProfileElement?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .red
        setupUI()
    }
    
    func setupUI(){
        setupStact()
        addToStack()
//        configureCell(poster: proImg?.filePath)
    }
    func setupStact(){
        stackView = contentView.HStack(spacing: 0)
        stackView?.fitToSuper(insets: .init(top: 0, left: 0, bottom:0, right:  0))
    }
    func addToStack(){
//        imageSlider.backgroundColor = .bluez
//        imageSlider.size(height: 200, heightPriority: 250)
        imageSlider.contentMode = .scaleAspectFill
        imageSlider.clipsToBounds = true
        stackView?.addArrangedSubview(imageSlider)
        
        
        titleLbl.textColor = .black
        titleLbl.numberOfLines = 0
        titleLbl.font = UIFont.systemFont(ofSize: 16)
        stackView?.addArrangedSubview(titleLbl)
    }
    
    func configureCell(poster: URL?) {
//     imageSlider.sd_setImage(with: poster, completed: nil)
//        imageSlider.sd_setImage(with: poster, placeholderImage: UIImage(named: "placeholder-image"), options: .avoidAutoSetImage, completed: nil)
       // movieTitle.text = title
        imageSlider.sd_setImage(with: poster, placeholderImage: nil, completed: { (image, error, cacheType, url) -> Void in
            if ((error) != nil) {
                        // set the placeholder image here
                self.imageSlider.image = image//UIImage(named: "placeholder-image")
                    } else {
                        // success ... use the image
                        self.imageSlider.image = image
                    }
                })
    }
 
    
    required init?(coder: NSCoder) {  fatalError("init(coder:) has not been implemented")  }
}




class ScaledHeightImageView: UIImageView {

    override var intrinsicContentSize: CGSize {

        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
 
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio

            return CGSize(width: myViewWidth, height: scaledHeight)
        }

        return CGSize(width: -1.0, height: -1.0)
    }

}

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
    let size = image.size
    
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(origin: .zero, size: newSize)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
}
