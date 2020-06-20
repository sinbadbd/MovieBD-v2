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
    
    var showID = MyUILabel()
    
    var movie = [Movie]()
    var result = [Result]()
    var movieDetails : MovieDetails?
    var genres = [Genre]()
    
    
    
    
    let label = UILabel()
    
    
    
    let topSliderImage: UIImageView = UIImageView()
    let movieTitleLabel :UILabel = UILabel()
    let playVedioButton: UIButton = UIButton(type: .system)
    let posterThumImage:UIImageView = UIImageView()
    
    
    let ratingMainView : UIView = UIView()
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    let trackLayer: CAShapeLayer = CAShapeLayer()
    let movieOverViewContainer = UIView()
    let userScoreLabel: UILabel =  UILabel()
    
    let overviewTextLabel: UILabel = UILabel()
    let fullCastCrewLabel: UILabel = UILabel()
    let textlayer = CATextLayer()
    let basickAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    // var favButton = MyButton()
    
    
    let movieTypeScrollView = UIScrollView()
    
    var favButton = UIButton(type: .system)
    
    var isSelectedButton : Bool = false
   var coinV:UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        isTopbar = false
        resetBase()
        view.backgroundColor = .white
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // your code here
            self.getDetailsDtaa()
        }
        
        print("detailsId \(String(describing: detailsId))")
    }
    
    
    var detailsId : Int? {
        didSet {
            //  print("id", id)
        }
    }
    func getDetailsDtaa(){
        
        
        APIClient.getMovieId(id: detailsId ?? 0) { (response, error) in
            print(APIClient.EndPoints.getMovieDetailsId(self.detailsId ?? 0).url)
            if let response = response {
                print(response)
                self.movieDetails = response
                self.genres = response.genres ?? []
                
                DispatchQueue.main.async {
                    

                    self.setupDetailsUI()
                    self.ratingView()
                    
                }
            }
            
        }
    }
    
    func setupDetailsUI(){
        
        contentView.addSubview(topSliderImage)
        topSliderImage.backgroundColor = .gray
        topSliderImage.isUserInteractionEnabled = true
        topSliderImage.contentMode = .scaleAspectFill
        topSliderImage.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              leading: contentView.leadingAnchor,
                              bottom: nil,
                              trailing: contentView.trailingAnchor,
                              padding: .init(),
                              size: CGSize(width: topSliderImage.frame.width, height: 280)
        )
        
        
        topSliderImage.addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.text = "\(String(describing: self.movieDetails?.title ?? ""))"
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        movieTitleLabel.numberOfLines = 5
        movieTitleLabel.anchor(top: nil, leading: movieTitleLabel.leadingAnchor, bottom: topSliderImage.bottomAnchor, trailing: topSliderImage.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 10), size: CGSize(width: 250, height: movieTitleLabel.frame.height.dynamic()))
        
        //
        topSliderImage.addSubview(posterThumImage)
        posterThumImage.translatesAutoresizingMaskIntoConstraints  = false
        posterThumImage.backgroundColor = .green
        posterThumImage.layer.cornerRadius = 12
        posterThumImage.layer.masksToBounds = true
        posterThumImage.clipsToBounds = true
        posterThumImage.layer.shadowRadius = 0.5
        posterThumImage.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        posterThumImage.layer.shadowOffset = CGSize(width: 3, height: 3)
        posterThumImage.layer.shadowOpacity = 0.7
        posterThumImage.anchor(top: nil, leading: topSliderImage.leadingAnchor, bottom: topSliderImage.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: -120, right: 0), size: CGSize(width: 120, height: 180))
        
        
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
        
//
//        movieOverViewContainer.addSubview(userScoreLabel)
//        userScoreLabel.translatesAutoresizingMaskIntoConstraints = false
//        userScoreLabel.text = "User Score"
//        userScoreLabel.font = UIFont.systemFont(ofSize: 12)
//        userScoreLabel.textColor = .black
//        userScoreLabel.textAlignment = .center
//        userScoreLabel.anchor(top: ratingMainView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 70, height: userScoreLabel.frame.height))
        
        //        var xOffest:CGFloat = 80
        //        self.favButton = UIButton(frame: CGRect(x: xOffest, y: 10, width: 50, height: 50))
        //        xOffest += 55
        //        favButton.tag = 1
        //        favButton.setImage(UIImage(named: "heart"), for: .normal)
        //        favButton.layer.cornerRadius = favButton.frame.width / 2
        //        favButton.layer.borderWidth = 3
        //        favButton.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        //        self.movieOverViewContainer.addSubview(favButton)
        //        favButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        //        favButton.addTarget(self, action: #selector(handleFavButton), for: .touchUpInside)
        
        
        var xOffest:CGFloat = 80
        let colorValus = ["heart","favorite","bookmark"]
        for color in 0..<colorValus.count {
            let button = UIButton(frame: CGRect(x: xOffest, y: 10, width: 50, height: 50))
            xOffest += 55
            button.tag = color
            button.setImage(UIImage(named: "\(colorValus[color])"), for: .normal)
            button.layer.cornerRadius = button.frame.width / 2
            button.layer.borderWidth = 3
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
//        movieTypeScrollView.anchor(top: ratingMainView.bottomAnchor,
//                                   leading: nil,
//                                   bottom: movieTypeScrollView.bottomAnchor,
//                                   trailing: nil,
//                                   padding: .init(top: 0, left:5 , bottom: 0, right: 5),
//                                   size: CGSize(width: movieTypeScrollView.frame.width, height: 10)
//        )
//        movieTypeScrollView.backgroundColor = .red
//        movieTypeScrollView.contentSize = CGSize(width: movieTypeScrollView.frame.width, height: movieTypeScrollView.frame.height)
//        movieTypeScrollView.updateConstraints()
//        view.layoutIfNeeded()
//         let contentWidth = balanceView.frame.size.width - leftSpace*2
        
        coinV = getCoinView(rect: CGRect(x: 10, y: 70, width: self.view.frame.width-20, height: 36.dynamic()))
               movieOverViewContainer.addSubview(coinV)
        
        
        
        contentView.addSubview(overviewTextLabel)
      //  overviewTextLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewTextLabel.text = "\(movieDetails?.overview ?? "")"
      //   overviewTextLabel.backgroundColor = .red
        overviewTextLabel.numberOfLines = 0
        overviewTextLabel.font = UIFont.systemFont(ofSize: 16)
        overviewTextLabel.anchor(top: ratingMainView.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 60, left: 10, bottom: 40, right: 15), size: CGSize(width: overviewTextLabel.frame.width, height: overviewTextLabel.frame.height))
        
        
        
        
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
            coinBtn.addTarget(self, action: #selector(coinPressed), for: .touchUpInside)
            coinBtn.frame = CGRect(x: 60.dynamic() * CGFloat(i) + 3.dynamic() * CGFloat(i), y: 0, width: 60.dynamic(), height: 30)
            coinBtn.layer.cornerRadius = coinBtn.frame.size.height*0.43;
            coinBtn.setTitle("\(aDict.name ?? "")", for: UIControl.State.normal)
            coinBtn.setTitleColor(.black, for: UIControl.State.normal)
            coinBtn.backgroundColor = .green
            coinBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            coinView.addSubview(coinBtn)
            coinView.contentSize = CGSize(width: coinBtn.frame.origin.x+coinBtn.frame.size.width, height: coinView.frame.size.height)
            
        }
        return coinView
    }
    @objc func coinPressed(sender:UIButton) {
                 UIView.animate(withDuration: TimeInterval(0.1), delay: 0.0, options: [], animations: {
                     sender.alpha = 0.5
                 }) { finished in
                     sender.alpha = 1.0
                  for aView in self.coinV.subviews {
                      if  aView is UIButton {
                          let coinBtn = aView as! UIButton
                          coinBtn.setTitleColor(.black, for: UIControl.State.normal)
                          coinBtn.backgroundColor = .green
                      }
                  }
                  
                  sender.setTitleColor(.white, for: UIControl.State.normal)
                  sender.backgroundColor = btnColorBlue
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
        let selectedItem = sender.tag
        
        if selectedItem == 0 {
            
            
            if isSelectedButton ==  false {
                sender.setImage(UIImage(named: "heart-selected"), for: .normal)
                self.isSelectedButton = true
                print(isSelectedButton)
            }else {
                sender.setImage(UIImage(named: "heart"), for: .normal)
                self.isSelectedButton = false
                print(self.isSelectedButton)
            }
            //             self.isSelectedButton = false
            
        } else if selectedItem == 1 {
            print("watch list: \(selectedItem)")
            if isSelectedButton ==  false {
                sender.setImage(UIImage(named: "fav-selected"), for: .normal)
                self.isSelectedButton = true
                print(isSelectedButton)
            }else {
                sender.setImage(UIImage(named: "favorite"), for: .normal)
                self.isSelectedButton = false
                print(self.isSelectedButton)
            } 
            
        } else {
            print("share: \(selectedItem)")
            
            if isSelectedButton ==  false {
                sender.setImage(UIImage(named: "bookmark-selected"), for: .normal)
                self.isSelectedButton = true
                print(isSelectedButton)
            }else {
                sender.setImage(UIImage(named: "bookmark"), for: .normal)
                self.isSelectedButton = false
                print(self.isSelectedButton)
            }
            
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
    @objc func handleVedioPlayer(){
        print("hi")
    }
}
