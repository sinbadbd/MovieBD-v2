//
//  Helper.swift
//  MovieDB-v2
//
//  Created by Imran on 29/8/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import Foundation
import UIKit

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
