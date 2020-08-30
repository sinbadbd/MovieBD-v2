//
//  Helper.swift
//  MovieDB-v2
//
//  Created by Imran on 29/8/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import Foundation
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



func getAttributedText(string:String, font:UIFont, color:UIColor, lineSpace:Float, alignment:NSTextAlignment) -> NSMutableAttributedString{
    let textStyle = NSMutableParagraphStyle()
    textStyle.alignment=alignment
    textStyle.lineSpacing=CGFloat(lineSpace)
    //paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
    let aMutableString = NSMutableAttributedString(
        string: string,
        attributes:[NSAttributedString.Key.font:font,NSAttributedString.Key.paragraphStyle:textStyle,NSAttributedString.Key.foregroundColor:color])
    return aMutableString
}
/**
 Removes UIViewController comparing provided class name from UINavigationController's UIViewController stack
 - className : class name of UIViewController
 **/
func removeVCFromStack(className : AnyClass) -> Void {
 let mutableArray: NSMutableArray = (navController.viewControllers as NSArray).mutableCopy() as! NSMutableArray
 var isRemoved:Bool = false
     for i in 0..<(navController.viewControllers.count-1){
         let vc:UIViewController = navController.viewControllers[i]
         if vc.isKind(of: className) {
             mutableArray.remove(vc)
             isRemoved = true
         }
     }
 if isRemoved {
     navController.setViewControllers(mutableArray as! [UIViewController], animated: false)
 }
 }

func gotToPage(_ className: AnyClass) {
    for controller in navController.viewControllers {
        if controller.isKind(of: className) {
            navController.popToViewController(controller, animated: true)
            break
        }
    }
}
