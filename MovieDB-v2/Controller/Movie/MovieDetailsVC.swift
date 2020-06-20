//
//  MovieDetailsVC.swift
//  MovieDB-v2
//
//  Created by Imran on 19/6/20.
//  Copyright © 2020 portoni/Users/imran/Desktop/iOS-Projects/MovieDB-v2/MovieDB-v2/ApiClinetcs. All rights reserved.
//

import UIKit
class MovieDetailsVC: BaseScrollView {
    
    // var detailsId : Int = 0
    
    var showID = MyUILabel()
    
    var movie = [Movie]()
    var result = [Result]()
    var movieDetails : MovieDetails?
    let label = UILabel()
    
    
    //    fileprivate var detailsId : Int
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // your code here
            self.getDetailsDtaa()
        }
        
        self.setupUI()
        self.ratingView()
        print("detailsId \(String(describing: detailsId))")
    }
    
    // Dependency injection constructor
    //    init(appId : Int) {
    //
    //        super.init()
    //          self.detailsId = appId
    //      }
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
                
                
                DispatchQueue.main.async {
                    
                    //                    self.setupUI()
                    
                }
            }
            
        }
        
    }
    
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
    
    
    func setupUI(){
        
        contentView.addSubview(topSliderImage)
        topSliderImage.backgroundColor = .red
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
        movieTitleLabel.text = "THE AVENGERS | THE END GAME | "
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
        movieOverViewContainer.backgroundColor = .blue
        movieOverViewContainer.anchor(top: topSliderImage.bottomAnchor, leading: posterThumImage.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: CGSize(width: movieOverViewContainer.frame.width, height: 100))
        
        
        movieOverViewContainer.addSubview(ratingMainView)
        ratingMainView.translatesAutoresizingMaskIntoConstraints = false
        // ratingMainView.backgroundColor = .blue
        ratingMainView.anchor(top: movieOverViewContainer.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 5), size: CGSize(width: 70, height: 70))
        
        
        movieOverViewContainer.addSubview(userScoreLabel)
        userScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        userScoreLabel.text = "User Score"
        userScoreLabel.font = UIFont.systemFont(ofSize: 12)
        userScoreLabel.textColor = .black
        userScoreLabel.textAlignment = .center
        userScoreLabel.anchor(top: ratingMainView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 70, height: userScoreLabel.frame.height))
        
        
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
