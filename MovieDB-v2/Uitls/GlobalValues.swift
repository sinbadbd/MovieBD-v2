//
//  GlobalValues.swift
//  MovieDB-v2
//
//  Created by Imran on 29/8/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import Foundation
import UIKit


// MARK:::
var GLOBAL_MOVIE_ID = 0
var PERSON_ID = 0
var totalVedioCount = 0
var totalImageCount = 0
//print("GLOBAL ID::: \(movie_id)")

var isWatchStatus = true
var isFavoriteStatue = true
var setMessageStatus = ""
var session_token = ""
var user_name = ""
//

let save_session_token = UserDefaults.standard.string(forKey: "session_token")
//print(name)?


var appFont: String = "Roboto"
var appFontLight: String = "Roboto-Light"
var appFontThin:String = "Roboto-Thin"
var appFontBold: String = "Roboto-Bold"
var appFontMedium: String = "Roboto-Medium"

var appFontItalic: String = "Roboto-Italic"
var appFontBoldItalic: String = "Roboto-BoldItalic"



//

extension UIViewController {
  func showAlert(title: String? = nil, message: String? = nil) {
    let alertController = UIAlertController(title: title, message:
      message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
    }))
    self.present(alertController, animated: true, completion: nil)
  }
}
