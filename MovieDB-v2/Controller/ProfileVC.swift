//
//  ProfileVC.swift
//  MovieDB-v2
//
//  Created by Imran on 19/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit

class ProfileVC: BaseVC {

    let test = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isTopbar = false
        resetBase()
//        contentView.backgroundColor = .cyan
//        view.backgroundColor = .red
        // Do any additional setup after loading the view.
        test.frame = CGRect(x: 20, y:50, width: test.frame.width, height: 3000)
        test.text  = "sd "
        contentView.addSubview(test)
        test.backgroundColor = .green
//        setContentHeight(height: 5000)
        setContentHeight(height: contentView.frame.height)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
