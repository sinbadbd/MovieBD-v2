//
//  ArtistProfileVC.swift
//  MovieDB-v2
//
//  Created by Imran on 20/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit
import SDWebImage

class ArtistProfileVC : BaseVC {
    
    let TOPSLIDER = "TOPSLIDER"
    
    //    let scrollView = UIScrollView()
    //    let contentView = UIView()
    let topSliderImage: UIImageView = UIImageView()
    
    //    let TOPSLIDER = "TOPSLIDER"
    
    private let colletionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    
    lazy var pageControl = UIPageControl()
    
    let artistView:UIView = UIView()
    let artistName:UILabel = UILabel()
    let artistDepartment:UILabel = UILabel()
    let artistImage:UIImageView = UIImageView()
    let artistDescription:UILabel = UILabel()
    let dateOfBirthLabel:UILabel = UILabel()
    
    let backButton:UIButton = UIButton(type: .system)
    
    var artist : Artist?
    var profile = [ProfileElement]()
    
    
    let artistMovieList = ArtistMovieView()
    
    
    var artistId : Int! {
        didSet {
            print("id", artistId)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isTopbar = false
        resetBase()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        fetchAPI()
        
        navigationItem.title = "Profile"
        
        colletionView.register(ProfileSliderCell.self, forCellWithReuseIdentifier: TOPSLIDER)
        colletionView.dataSource = self
        colletionView.delegate = self
        
        artistMovieList.callback = { (id) -> Void in
            print("callback - \(id)")
            print(id)
            let vc = MovieDetailsVC()
            //            vc.movie_id = id
            
            self.navigationController!.viewControllers.removeAll()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func fetchAPI(){ //2888: id
        APIClient.getArtistProfileId(id: PERSON_ID) { (response, error) in
            if let response = response {
                self.artist = response
                DispatchQueue.main.async {
                    self.artistName.text = response.name
                    self.artistDepartment.text = response.knownForDepartment
                    self.artistDescription.text = response.biography
                    self.dateOfBirthLabel.text = "Born: \(response.birthday ?? "" )"
                    if response.profilePath != nil {
                        let img = URL(string: "\(APIClient.EndPoints.PROFILE_FULL + response.profilePath!)")
                        self.artistImage.sd_setImage(with: img, completed: nil)
                    }
                    // self.colletionView.reloadData()
                }
            }
            
        }
        //2888 : id
        // TOP SLIDER IMAGE ß
        APIClient.getPersonImageId(id: PERSON_ID) { (response, error) in
            if let response = response {
                self.profile = response[0].profiles ?? []
                DispatchQueue.main.async {
                    self.colletionView.reloadData()
                }
            }
        }
        setupView()
        setTimer()
    }
    
    
    
    @objc func handleBack(_ sender : UIButton){
        print("hi")
        let home = MovieDetailsVC()
        self.present(home, animated: true, completion: nil)
    }
    
    // add timer for auto scrolling
    func setTimer() {
        let _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(autoScroll), userInfo: nil,
                                     repeats: true)
    }
    var x = 1
    // create auto scroll
    @objc func autoScroll() {
        self.pageControl.currentPage = x
        if self.x < 5 {
            let indexPath = IndexPath(item: x, section: 0)
            self.colletionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.x = self.x + 1
        } else {
            self.x = 0
            self.colletionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    func setupView(){
        
        contentView.addSubview(colletionView)
        // colletionView.backgroundColor = .white
        colletionView.backgroundColor = .white
        colletionView.translatesAutoresizingMaskIntoConstraints = false
        colletionView.showsHorizontalScrollIndicator = false
        colletionView.isPagingEnabled = true
        //        colletionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size : CGSize(width: colletionView.frame.width, height: 300))
        
        colletionView.position(top: contentView.topAnchor)
        colletionView.size(  height: 250, dimensionWidth: contentView.widthAnchor)
        view.addSubview(pageControl)
        
        
        pageControl.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,
                           padding: .init(top: 220, left: 0, bottom: 50, right: 0), size : CGSize(width:200, height: 40))
        
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = profile.count
        print(" pc.numberOfPages - \( pageControl.numberOfPages)")
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        view.layoutIfNeeded()
        
        //        pageControl.translatesAutoresizingMaskIntoConstraints = false
        //             pageControl.backgroundColor = .yellow
        //        pageControl.centerInSuperview()
        //    self.setTimer()
        //        self.autoScroll()
        
        
        
        contentView.addSubview(artistView)
        artistView.translatesAutoresizingMaskIntoConstraints = false
        artistView.backgroundColor = #colorLiteral(red: 0.2033947077, green: 0.2201191104, blue: 0.2415348346, alpha: 1)
        artistView.anchor(top: colletionView.bottomAnchor, leading: colletionView.leadingAnchor, bottom: nil, trailing: colletionView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 0), size: CGSize(width: artistView.frame.width, height: 250))
        //  artistView.addShadow(offset: CGSize(width: artistView.frame.width, height: -15), color: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1), opacity: 0.7, radius: 25)
        
        artistView.addSubview(artistName)
        artistName.translatesAutoresizingMaskIntoConstraints = false
        artistName.text = "--"
        artistName.textColor = .white
        artistName.font = UIFont.systemFont(ofSize: 30)
        artistName.anchor(top: artistView.topAnchor, leading: artistView.leadingAnchor, bottom: nil, trailing: artistView.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 15), size: CGSize(width: artistName.frame.width, height: artistName.frame.height))
        
        artistView.addSubview(artistDepartment)
        artistDepartment.translatesAutoresizingMaskIntoConstraints = false
        artistDepartment.text = "--"
        artistDepartment.textColor = #colorLiteral(red: 0.4411551162, green: 0.496842643, blue: 0.501960814, alpha: 1)
        artistDepartment.font = UIFont.systemFont(ofSize: 16)
        artistDepartment.anchor(top: artistName.bottomAnchor, leading: artistView.leadingAnchor, bottom: nil, trailing: artistView.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 15), size: CGSize(width: artistDepartment.frame.width, height: artistDepartment.frame.height))
        
        
        artistView.addSubview(artistImage)
        artistImage.translatesAutoresizingMaskIntoConstraints = false
        artistImage.contentMode = .scaleAspectFit
        artistImage.layer.cornerRadius = 8
        artistImage.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        artistImage.anchor(top: artistDepartment.bottomAnchor, leading: artistView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 10, bottom: 0, right: 15), size: CGSize(width: 100, height: 150))
        artistImage.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        artistImage.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        artistView.addSubview(artistDescription)
        artistDescription.translatesAutoresizingMaskIntoConstraints = false
        artistDescription.numberOfLines = 5
        artistDescription.textColor = UIColor.white
        artistDescription.anchor(top: artistDepartment.bottomAnchor, leading: artistImage.trailingAnchor, bottom: nil, trailing: artistView.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 0, right: 15), size: CGSize(width: 250, height: artistDescription.frame.height))
        
        artistView.addSubview(dateOfBirthLabel)
        dateOfBirthLabel.translatesAutoresizingMaskIntoConstraints = false
        dateOfBirthLabel.numberOfLines = 1
        dateOfBirthLabel.textColor = UIColor.white
        dateOfBirthLabel.font = UIFont.systemFont(ofSize: 18)
        dateOfBirthLabel.anchor(top: artistDescription.bottomAnchor, leading: artistImage.trailingAnchor, bottom: nil, trailing: artistView.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 0, right: 15))
        
        
        let keyWindow = UIApplication.shared.keyWindow
        let artistmovieList = ArtistMovieView()
        contentView.addSubview(artistmovieList)
        artistmovieList.translatesAutoresizingMaskIntoConstraints = false
        artistmovieList.anchor(top: artistView.bottomAnchor, leading: contentView.trailingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 0, right: 0), size: CGSize(width: (keyWindow?.frame.width)!, height: 300))
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        // And some actions
        print("tappedIma====")
        //        let artistSlider =  ArtistImageSlider()
        //        self.present(artistSlider, animated: true, completion: nil)
        
    }
    
}

extension ArtistProfileVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("profile.count\(profile.count)")
        //        let profile = profile
        return profile.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TOPSLIDER, for: indexPath) as! ProfileSliderCell
        // cell.backgroundColor = .red
        let apiResponse = profile[indexPath.item]
        // if apiResponse.profiles[0]. != nil {
        let img = URL(string: "\(APIClient.EndPoints.POSTER_URL + apiResponse.filePath!)")
        cell.imageSlider.sd_setImage(with: img, completed: nil)
        //  }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    
}
