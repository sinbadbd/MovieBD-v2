//
//  MovieDetailsVC.swift
//  MovieDB-v2
//
//  Created by Imran on 19/6/20.
//  Copyright © 2020 portoni/Users/imran/Desktop/iOS-Projects/MovieDB-v2/MovieDB-v2/ApiClinetcs. All rights reserved.
//

import UIKit


class MovieDetailsVC: BaseVC {
    
    // var detailsId : Int = 0
    
    var movieVedioTitle = UILabel()
    
    
    var movieDetails : MovieDetails?
    var favResponse : MarkFavoriteResponse?
    var movie = [Movie]()
    var result = [Result]()
    var genres = [Genre]()
    var casts = [MovieCast]()
    
    
    
    let topSliderImage  : UIImageView = UIImageView()
    let movieTitleLabel : UILabel    = UILabel()
    let playVedioButton : UIButton   = UIButton(type: .system)
    let posterThumImage : UIImageView = UIImageView()
    
    
    let ratingMainView  : UIView = UIView()
    let shapeLayer      : CAShapeLayer = CAShapeLayer()
    let trackLayer      : CAShapeLayer = CAShapeLayer()
    let movieOverViewContainer = UIView()
    let userScoreLabel  : UILabel =  UILabel()
    
    let overviewTextLabel: UILabel = UILabel()
    let fullCastCrewLabel: UILabel = UILabel()
    let textlayer = CATextLayer()
    let basickAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    // var favButton = MyButton()
    
    
    let movieTypeScrollView = UIScrollView()
    
    var favButton = UIButton(type: .system)
    
    
    var coinV:UIScrollView!
    
    var movieCastView  = MovieCastView()
    var movieVedioList = MovieVedioListView()
    var movieImageList = MovieImageListView()
    var similarMovieList = SimilarMovieView()
    
    var recommandMovieList = RecommandationMovieView()
    
    
    let movieDetailsText = UILabel()
    
    let userDefault = UserDefaults.standard
    
    var isSelectedFavButton : Bool = false
    var isSelectedStarButton : Bool = false
    var isSelectedBookButton : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isTopbar = false
        resetBase()
        view.backgroundColor = .white
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // your code here
            self.getDetailsData()
        } 
        callBackNavigation()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //          navigationItem.title = "\(String(describing: movieDetails?.originalTitle))"
    }
    
    func callBackNavigation(){
        
        movieCastView.callback = { (id) -> Void in
            print("callback - \(id)")
            // print(id)
            let vc = ArtistProfileVC()
            PERSON_ID = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        recommandMovieList.callback = { (id) -> Void in
            print("callback - \(id)")
            let vc = MovieDetailsVC()
            GLOBAL_MOVIE_ID = id
            //
            self.navigationController?.setViewControllers([vc], animated: true)
            self.navigationController?.setNeedsStatusBarAppearanceUpdate()
        }
        similarMovieList.callback = { (id) -> Void in
            print("callback - \(id)")
            let vc = MovieDetailsVC()
            GLOBAL_MOVIE_ID = id
            //
            self.navigationController?.setViewControllers([vc], animated: true)
            self.navigationController?.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    //
    func getDetailsData(){
        APIClient.getMovieId(id: GLOBAL_MOVIE_ID ) { (response, error) in
            print(APIClient.EndPoints.getMovieDetailsId(GLOBAL_MOVIE_ID).url)
            if let response = response {
                print(response)
                self.movieDetails = response
                self.genres = response.genres ?? []
                
                DispatchQueue.main.async {
                    
                    if  response.backdropPath != nil {
                        let imgUrl = URL(string: "\(APIClient.EndPoints.BACKDROP_PATH + response.backdropPath!)")
                        self.topSliderImage.sd_setImage(with: imgUrl, completed: nil)
                    }
                    if response.posterPath != nil {
                        let posterURL = URL(string: "\(APIClient.EndPoints.POSTER_URL + response.posterPath!)")
                        self.posterThumImage.sd_setImage(with: posterURL, placeholderImage: UIImage(named: "frame-0"), options: .fromLoaderOnly, completed: nil)
                        
                    }
                    self.movieTitleLabel.text = "\(String(describing: self.movieDetails?.title ?? ""))"
                    self.overviewTextLabel.text = "\(self.movieDetails?.overview ?? "")"
                    self.ratingView()
                    self.navigationItem.title = "\(String(describing: self.movieDetails?.originalTitle ?? ""))"
                    self.setupDetailsUI()
                }
            }
            
        }
    }
    
    func setupDetailsUI(){
        
        contentView.addSubview(topSliderImage)
        //        topSliderImage.backgroundColor = .gray
        topSliderImage.isUserInteractionEnabled = true
        topSliderImage.contentMode = .scaleAspectFill
        
        
        topSliderImage.backgroundColor = .red
        topSliderImage.position(top: contentView.topAnchor, left: contentView.leadingAnchor)
        topSliderImage.size(height: 280 ,dimensionWidth: contentView.widthAnchor)
        
        topSliderImage.addSubview(movieTitleLabel)
        //        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = UIFont(name: appFontBold, size: 24)
        movieTitleLabel.numberOfLines = 0
        //        movieTitleLabel.backgroundColor = .green
        
        movieTitleLabel.position(bottom: topSliderImage.bottomAnchor, right: topSliderImage.trailingAnchor, insets: .init(top: 0, left: 0, bottom: 20, right: 20))
        movieTitleLabel.size(width: 210)
        
        
        //
        topSliderImage.addSubview(posterThumImage)
        posterThumImage.backgroundColor = .green
        posterThumImage.layer.cornerRadius = 12
        posterThumImage.layer.masksToBounds = true
        posterThumImage.clipsToBounds = true
        posterThumImage.layer.shadowRadius = 0.5
        posterThumImage.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        posterThumImage.layer.shadowOffset = CGSize(width: 3, height: 3)
        posterThumImage.layer.shadowOpacity = 0.7
        posterThumImage.position( left: topSliderImage.leadingAnchor, bottom: topSliderImage.bottomAnchor,
                                  insets: .init(top: 0, left: 10, bottom: -120, right: 0))
        posterThumImage.size( width: 120, height: 180)
        
        
        topSliderImage.addSubview(playVedioButton)
        playVedioButton.translatesAutoresizingMaskIntoConstraints = false
        playVedioButton.centerInSuperview()
        //playVedioButton.setGradientBackground(colorTop: UIColor(red: 249/255, green: 159/255, blue: 8/255, alpha: 1), colorBottom: UIColor(red: 219/255, green: 48/255, blue: 105/255, alpha: 1))
        playVedioButton.addTarget(self, action: #selector(handleVedioPlayer), for: .touchUpInside)
        playVedioButton.isUserInteractionEnabled = true
        //             playVedioButton.layer.cornerRadius = self.playVedioButton.frame.size.width / 2
        //             playVedioButton.layer.masksToBounds = true
        playVedioButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: CGSize(width: 60, height: 60))
        playVedioButton.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysOriginal), for: .normal)
        playVedioButton.clipsToBounds = true
        
        
        
        contentView.addSubview(movieOverViewContainer)
        //   movieOverViewContainer.translatesAutoresizingMaskIntoConstraints = false
        // movieOverViewContainer.backgroundColor = .blue
        movieOverViewContainer.anchor(top: topSliderImage.bottomAnchor, leading: posterThumImage.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: CGSize(width: movieOverViewContainer.frame.width, height: 120))
        
        
        movieOverViewContainer.addSubview(ratingMainView)
        ratingMainView.translatesAutoresizingMaskIntoConstraints = false
        // ratingMainView.backgroundColor = .blue
        ratingMainView.anchor(top: movieOverViewContainer.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 5), size: CGSize(width: 70, height: 70))
        
        var xOffest:CGFloat = 70
        let colorValus = ["heart","favorite","bookmark"]
        for color in 0..<colorValus.count {
            let button = UIButton(frame: CGRect(x: xOffest, y: 10, width: 45, height: 45))
            xOffest += 50
            button.tag = color
            button.setImage(UIImage(named: "\(colorValus[color])"), for: .normal)
            button.layer.cornerRadius = button.frame.width / 2
            button.layer.borderWidth = 1.5
            button.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
            button.addTarget(self, action: #selector(handleFavButton), for: .touchUpInside)
            self.movieOverViewContainer.addSubview(button)
        }
        
        
        movieTypeScrollView.frame = CGRect(x: 30, y: 50, width: movieTypeScrollView.frame.width, height: 40)
        movieTypeScrollView.backgroundColor = .red
        movieTypeScrollView.contentSize.height = 30
        //         contentSize = CGSize(width: paddi?ng * buttonWidth, height:  60)
        movieOverViewContainer.addSubview(movieTypeScrollView)
        
        coinV = getCoinView(rect: CGRect(x: 10, y: 70, width: self.contentView.frame.width-20, height: 36.dynamic()))
        movieOverViewContainer.addSubview(coinV)
        
        
        
        
        contentView.addSubview(overviewTextLabel)
        //  overviewTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //   overviewTextLabel.backgroundColor = .red
        overviewTextLabel.numberOfLines = 0
        overviewTextLabel.font = UIFont(name: appFont, size: 14)
        overviewTextLabel.anchor(top: ratingMainView.bottomAnchor,
                                 leading: contentView.leadingAnchor,
                                 bottom: nil, trailing: contentView.trailingAnchor,
                                 padding: .init(top: 60, left: 10, bottom: 40, right: 15)
            // size: CGSize(width: overviewTextLabel.frame.width, height: overviewTextLabel.frame.height)
        )
        overviewTextLabel.textColor = .black
        
        
        //
        let borderBottomView = UIView()
        contentView.addSubview(borderBottomView)
        borderBottomView.position(top: overviewTextLabel.bottomAnchor, left: contentView.leadingAnchor, bottom: nil, right: contentView.trailingAnchor, insets:   .init(top: 20, left: 15, bottom: 0, right: 15))
        borderBottomView.size(height: 0.2)
        borderBottomView.backgroundColor = .lightGray
        
        
        
        contentView.addSubview(movieDetailsText)
        movieDetailsText.position(top: borderBottomView.bottomAnchor, left: contentView.leadingAnchor, bottom: nil, right: borderBottomView.trailingAnchor, insets:  .init(top: 15, left: 15, bottom: 0, right: 15))
        
        
        
        
        // 0
        let attr0: NSMutableAttributedString = getAttributedText(string: "Status: ", font: UIFont(name: appFontBold, size: 14)!, color: .black, lineSpace: 5, alignment: .left)
        let attr01: NSMutableAttributedString = getAttributedText(string: " \(self.movieDetails?.status ?? "")\n", font: UIFont(name: appFontMedium, size: 15)!, color: .gray, lineSpace: 0, alignment: .left)
        
        
        // 1
        let attr1: NSMutableAttributedString = getAttributedText(string: "Release date: ", font: UIFont(name: appFontBold, size: 14)!, color: .black, lineSpace: 5, alignment: .left)
        
        let attr2: NSMutableAttributedString = getAttributedText(string: " \(self.movieDetails?.releaseDate ?? "")\n", font: UIFont(name: appFontMedium, size: 15)!, color: .gray, lineSpace: 0, alignment: .left)
        
        //2
        let attr3: NSMutableAttributedString = getAttributedText(string: "Run Time: ", font: UIFont(name: appFontBold, size: 14)!, color: .black, lineSpace: 5, alignment: .left)
        let attr4: NSMutableAttributedString = getAttributedText(string: " \(self.movieDetails?.runtime ?? 0)m \n", font: UIFont(name: appFontMedium, size: 15)!, color: .gray, lineSpace: 0, alignment: .left)
        
        //2
        
        let attr5: NSMutableAttributedString = getAttributedText(string: "Revenue: ", font: UIFont(name: appFontBold, size: 14)!, color: .black, lineSpace: 5, alignment: .left)
        let attr6: NSMutableAttributedString = getAttributedText(string: " $\(self.movieDetails?.revenue ?? 0) \n", font: UIFont(name: appFontMedium, size: 15)!, color: .gray, lineSpace: 0, alignment: .left)
        
        
        //
        
        //        attr0.append(attr1)
        attr0.append(attr01)
        attr0.append(attr1)
        attr0.append(attr2)
        attr0.append(attr3)
        attr0.append(attr4)
        attr0.append(attr5)
        attr0.append(attr6)
        movieDetailsText.attributedText = attr0
        movieDetailsText.numberOfLines = 0
        
        //runtime
        
        
        let topActorTitle = UILabel()
        contentView.addSubview(topActorTitle)
        topActorTitle.text = "Top Cast"
        topActorTitle.font = UIFont(name: appFontBold, size: 24)
        topActorTitle.position(top: movieDetailsText.bottomAnchor,left: contentView.leadingAnchor, insets: .init(top: 15, left: 10, bottom: 0, right: 0    ))
        //        topActorTitle.size(height: 20)
        
        // MARK:: MOVIE CAST
        contentView.addSubview(movieCastView)
        movieCastView.anchor(top: topActorTitle.bottomAnchor,
                             leading: contentView.leadingAnchor,
                             bottom: nil,
                             trailing: contentView.trailingAnchor,
                             padding: .init(top: 0, left: 10, bottom: 0, right: 20),
                             size: CGSize(width: .init(), height:280)
        )
        
        
        let movieDesView = UIView()
        contentView.addSubview(movieDesView)
        movieDesView.position(top: movieCastView.bottomAnchor, left: contentView.leadingAnchor, bottom: nil, right: contentView.trailingAnchor, insets: .init(top: 20, left: 15, bottom: 0, right:15))
        
        movieDesView.backgroundColor = .red
        
        let titleDes = UILabel()
        movieDesView.addSubview(titleDes)
        titleDes.position(top: movieDesView.topAnchor, left: movieDesView.leadingAnchor, bottom: movieDesView.bottomAnchor, right: movieDesView.trailingAnchor, insets: .init(top: 10, left: 10, bottom: 10, right: 10))
        titleDes.text = "Functions can be nested. Nested functions have access to variables that were declared in the outer function. You can use nested functions to organize the code in a function that is long or complex."
        titleDes.numberOfLines = 0
        
        
        
        // movieCastView.backgroundColor = .red
        contentView.addSubview(movieVedioTitle)
        movieVedioTitle.anchor(top: movieDesView.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 20))
        movieVedioTitle.centerXInSuperview()
        
        let attrStr1: NSMutableAttributedString = getAttributedText(string: "Vedios ", font: UIFont(name: appFontBold, size: 18)!, color: .black, lineSpace: 5, alignment: .left)
        let attrStrCate: NSMutableAttributedString = getAttributedText(string: " \(totalVedioCount)", font: UIFont(name: appFontMedium, size: 18)!, color: .gray, lineSpace: 0, alignment: .left)
        
        attrStr1.append(attrStrCate)
        movieVedioTitle.attributedText = attrStr1
        movieVedioTitle.numberOfLines = 0
        
        
        // MARK: MOVIE VEDIOS LIST
        contentView.addSubview(movieVedioList)
        movieVedioList.position(top: movieVedioTitle.bottomAnchor, left: movieVedioTitle.leadingAnchor, bottom: nil, right: contentView.trailingAnchor, insets: .init(top: 20, left: 0, bottom: 0, right: 0))
        movieVedioList.size( height: 200, dimensionWidth: contentView.widthAnchor)
        movieVedioList.backgroundColor = .blue
        
        // MARK: MOVIE IMAGES LIST
        contentView.addSubview(movieImageList)
        movieImageList.position(top: movieVedioList.bottomAnchor, left: movieVedioTitle.leadingAnchor, bottom:nil, right: contentView.trailingAnchor, insets: .init(top: 20, left: 0, bottom: 0, right: 0))
        movieImageList.size( height: 200, dimensionWidth: contentView.widthAnchor)
        
        let reviewView = UIView()
        contentView.addSubview(reviewView)
        reviewView.position(top: movieImageList.bottomAnchor,left: contentView.leadingAnchor, bottom: nil, right: contentView.trailingAnchor,insets: .init(top: 15, left: 10, bottom: 20, right: 10))
        reviewView.size(  height: 50 )
        //        reviewView.backgroundColor = .tertiaryLabel
        reviewView.layer.cornerRadius = 4
        
        let userReviewTitle = UILabel()
        reviewView.addSubview(userReviewTitle)
        userReviewTitle.position(top: reviewView.topAnchor, left: reviewView.leadingAnchor, insets: .init(top: 10, left: 15, bottom: 0, right: 0))
        userReviewTitle.text = "User Reviews"
        userReviewTitle.font = UIFont(name: appFont, size: 18)
        
        let seeAllButtons = UIButton()
        reviewView.addSubview(seeAllButtons)
        seeAllButtons.position(top: reviewView.topAnchor,  right:reviewView.trailingAnchor, insets: .init(top: 10, left: 0, bottom: 0, right: 15))
        seeAllButtons.setTitleColor(.blue, for: .normal)
        //        let text =
        seeAllButtons.setTitle("See All", for: .normal)
        seeAllButtons.addTarget(self, action: #selector(handleSeeAll), for: .touchUpInside)
        seeAllButtons.titleLabel?.font = UIFont(name: appFont, size:   14)
        
        
        contentView.addSubview(recommandMovieList)
        
        recommandMovieList.position(top: reviewView.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, insets: .init(top: 20, left: 15, bottom: 20, right: 0))
        recommandMovieList.size( height: 250, dimensionWidth: contentView.widthAnchor)
        //        recommandMovieList.backgroundColor = .green
        
        //similarMovieList
        contentView.addSubview(similarMovieList)
        
        similarMovieList.position(top: recommandMovieList.bottomAnchor, left: contentView.leadingAnchor, bottom: contentView.bottomAnchor, right: contentView.trailingAnchor, insets: .init(top: 20, left: 15, bottom: 20, right: 0))
        similarMovieList.size( height: 250, dimensionWidth: contentView.widthAnchor)
        similarMovieList.backgroundColor = .clear
        
    }
    
    @objc func handleSeeAll(_ sender: UIButton){
        print(sender.tag)
        let vc = MovieReviewVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getCoinView(rect:CGRect) -> UIScrollView {
        let coinView = UIScrollView(frame: rect)
        coinView.showsHorizontalScrollIndicator = false
        
        print(genres)
        
        // let arr = ["Animation","Animation","avenger","Animation","game","lalal .","Animation","data"]
        
        for i in 0..<genres.count {
            let aDict = genres[i]
            //  let coinAmount = aDict["amount"] as! Int
            let coinBtn = UIButton(type: .custom)
            coinBtn.tag = i
            coinBtn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            coinBtn.frame = CGRect(x: 60.dynamic() * CGFloat(i) + 2.dynamic() * CGFloat(i), y: 0, width: 60.dynamic(), height: 24.dynamic())
            coinBtn.layer.cornerRadius = coinBtn.frame.size.height*0.33;
            coinBtn.setTitle("\(aDict.name ?? "")", for: UIControl.State.normal)
            coinBtn.setTitleColor(.black, for: UIControl.State.normal)
            coinBtn.layer.borderColor = UIColor.link.cgColor
            coinBtn.layer.borderWidth = 1
            //            coinBtn.backgroundColor = .green
            coinBtn.titleLabel?.font = UIFont(name: appFontLight, size: 12)
            coinView.addSubview(coinBtn)
            coinView.contentSize = CGSize(width: coinBtn.frame.origin.x+coinBtn.frame.size.width, height: coinView.frame.size.height)
            
        }
        return coinView
    }
    @objc func buttonPressed(sender:UIButton) {
        UIView.animate(withDuration: TimeInterval(0.1), delay: 0.0, options: [], animations: {
            sender.alpha = 0.5
        }) { finished in
            sender.alpha = 1.0
            for aView in self.coinV.subviews {
                if  aView is UIButton {
                    let coinBtn = aView as! UIButton
                    coinBtn.setTitleColor(.black, for: UIControl.State.normal)
                    //                    coinBtn.backgroundColor = .white
                }
            }
            
            // sender.setTitleColor(.white, for: UIControl.State.normal)
            //sender.backgroundColor = btnColorBlue
            //                  let aDict = self.comissionArray[sender.tag]
            //                  self.selectedAmnt = aDict["amount"] as? Double ?? 0.0
            //                  let discountAmount = aDict["discount"] as? Double ?? 0.0
            //                  let total = self.selectedAmnt-discountAmount
            //                  self.amountTxF.text = "\(self.selectedAmnt.commaRepresentation)"
            //                  self.amntLbl.text = getFormatedAmount(Int(self.selectedAmnt))
            //                  self.earningLbl.text = getFormatedAmount(Int(discountAmount))
            //                  self.totalLbl.text = getFormatedAmount(Int(total))
            
        }
    }
    
    
    @objc func handleFavButton(sender: UIButton){
        print(sender.tag)
        
        var selectedItem = sender.tag
        
        if selectedItem == 0 {
            
            
            if isSelectedFavButton ==  false {
                if userDefault.getLoginSatus() == true {
                    
                    print("save_session_token: \(save_session_token ?? "")")
                    
                    sender.setImage(UIImage(named: "heart-selected"), for: .normal)
                    isSelectedFavButton = isFavoriteStatue
                    
                    if save_session_token ==  save_session_token {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                            // your code here
                            self.makeFavoriteMovie()
                            
                        }
                    }
                    
                    print("isSelecteFavoriteButton: \(isSelectedFavButton)")
                }else {
                    let vc = LoginVC()
                    // self.present(vc, animated: true, completion: nil)
                    navigationController?.pushViewController(vc, animated: true)
                }
                selectedItem = sender.tag
            }else {
                sender.setImage(UIImage(named: "heart"), for: .normal)
                isSelectedFavButton = false
                print(isSelectedFavButton)
            }
            //                      isSelectedFavButton = false
            //            return
        } else if selectedItem == 1 {
            print("save_session_token: \(String(describing: save_session_token) )")
            print("watch list: \(selectedItem)")
            if isSelectedStarButton ==  false {
                sender.setImage(UIImage(named: "fav-selected"), for: .normal)
                isSelectedStarButton = true
                
                
                
                print(isSelectedStarButton)
            }else {
                sender.setImage(UIImage(named: "favorite"), for: .normal)
                isSelectedStarButton = false
                print(isSelectedStarButton)
            } 
            //             selectedItem = sender.tag
        } else {
            print("share: \(selectedItem)")
            
            if isSelectedBookButton ==  false {
                
                if userDefault.getLoginSatus() == true {
                    
                    print("save_session_token: \(save_session_token ?? "")")
                    
                    sender.setImage(UIImage(named: "bookmark-selected"), for: .normal)
                    isSelectedBookButton = true
                    
                    if save_session_token ==  save_session_token {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                            // your code here
                            self.markWatchMovieList()
                            
                        }
                    }
                    
                    print("isSelecteFavoriteButton: \(isSelectedFavButton)")
                }else {
                    let vc = LoginVC()
                    // self.present(vc, animated: true, completion: nil)
                    navigationController?.pushViewController(vc, animated: true)
                }
                
                
                print(isSelectedBookButton)
            }else {
                sender.setImage(UIImage(named: "bookmark"), for: .normal)
                isSelectedBookButton = false
                print(isSelectedBookButton)
            }
            //             selectedItem = sender.tag
        }
    }
    func ratingView(){
        ratingMainView.layer.addSublayer(trackLayer)
        trackLayer.frame =  CGRect(x: 35, y: 35, width: 0, height: 0)
        let circularPath = UIBezierPath(arcCenter:  movieOverViewContainer.center , radius: 25, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 7
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        
        
        ratingMainView.layer.addSublayer(shapeLayer)
        shapeLayer.frame =  CGRect(x: 35, y: 35, width: 0, height: 0)
        // let circularPath = UIBezierPath(arcCenter:  movieOverView.center , radius: 35, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        shapeLayer.lineWidth = 7
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        
        
        
        //Animation#
        basickAnimation.toValue = 0.5
        basickAnimation.duration = 3
        basickAnimation.fillMode = .forwards
        basickAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basickAnimation, forKey: "Basic")
        
        textlayer.frame = CGRect(x: -20, y: -12, width: 40, height: 22)
        textlayer.fontSize = 20
        textlayer.alignmentMode = .center
        textlayer.isWrapped = true
        self.textlayer.string = "\(String(describing:0.3))"
        textlayer.foregroundColor = UIColor.black.cgColor
        shapeLayer.addSublayer(textlayer) // caLayer is and instance of parent CALayer
    }
    
    
    func makeFavoriteMovie(){
        
        APIClient.markFavorite(movieId: GLOBAL_MOVIE_ID, favorite: isFavoriteStatue) { (success, error) in
            if success {
                //                self.favButton = success[0]
                print(success)
                self.showAlert(title: "Success", message: "\(setMessageStatus )")
            }else {
                self.showAlert(title: "Success", message: "\(setMessageStatus )")
            }
        }
    }
    
    
    func markWatchMovieList(){
        APIClient.markWatcMovie(movieId: GLOBAL_MOVIE_ID, watchList: isWatchStatus) { (success, error) in
            if success {
                //                self.favButton = success[0]
                print(success)
                self.showAlert(title: "Success", message: "\(setMessageStatus )")
            }else {
                self.showAlert(title: "Success", message: "\(setMessageStatus )")
            }
        }
    }
    
    @objc func handleVedioPlayer(_ sender: UIButton){
        let vedioPlayer = MovieVideoVC()
        vedioPlayer.id = self.movieDetails?.id
        //        print(  vedioPlayer.id)
        self.present(vedioPlayer, animated: true, completion: nil)
    }
}


