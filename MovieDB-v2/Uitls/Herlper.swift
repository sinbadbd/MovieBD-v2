//
//  Herlper.swift
//  MovieDB-v2
//
//  Created by Imran on 19/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit


func setViewBackgroundImageDash(vc:UIViewController) {
    let aview = UIView(frame: vc.view.bounds)
    aview.backgroundColor = UIColor.white//buttonColor
    vc.view.insertSubview(aview, at: 0)
    let background = UIImage(named: "")
    var imageView : UIImageView!
    imageView = UIImageView(frame: CGRect(x: vc.view.frame.width-vc.view.frame.width*0.7, y: 0, width: vc.view.frame.width*0.7, height: vc.view.frame.width*0.7))
    imageView.image = background
    imageView.contentMode =  .scaleAspectFit
    imageView.clipsToBounds = true
    imageView.backgroundColor = .clear
    aview.insertSubview(imageView, at: 1)
}

func getButtonWithImage(frame:CGRect, imgName:String, imgSz:CGSize, imgClr:UIColor?) ->UIButton {
    let aBtn = UIButton(type: .custom)
    aBtn.frame = frame
    let image: UIImage? = UIImage(named:imgName ?? "")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    let imgView = UIImageView(frame: CGRect(x: aBtn.frame.size.width*0.5-imgSz.width*0.5, y: aBtn.frame.size.height*0.5-imgSz.height*0.5, width: imgSz.width, height: imgSz.height))
    imgView.tag = 1
    imgView.image = UIImage(named: imgName)
   if imgClr != nil {
       imgView.image = image
       imgView.tintColor = imgClr
   }
   
    aBtn.addSubview(imgView)
    
    return aBtn
}



//MARK: Color
func hexToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


let colorBlue = hexToUIColor(hex: "#007AD0")
let btnColorBlue = colorBlue
let txtColorBlue = colorBlue
//MARK: Extensions
var factX=UIScreen.main.bounds.size.width/375
var factY=UIScreen.main.bounds.size.height/667
var actualFactX = UIScreen.main.bounds.size.width/375

let gapX:CGFloat = 14.dynamic()
let contentW:CGFloat = UIScreen.main.bounds.size.width-gapX*2



extension CGFloat{
    
    func dynamic() -> CGFloat {
        return self*factX
    }
}

extension Int{
    
    func dynamic() -> CGFloat {
        return CGFloat(self)*factX
    }
}

extension Double{
    
    func dynamic() -> CGFloat {
        return CGFloat(self)*factX
    }
}
