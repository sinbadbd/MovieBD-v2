//
//  SeparatorCell.swift
//  ViewKit
//
//

import UIKit
 

public class SeparatorCell: UITableViewCell, Reusable {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
    }

    public func configure(height: CGFloat, color: UIColor = .white, leftPadding: CGFloat, rightPadding: CGFloat) {
        mainViewHeight.constant = height
        mainView.backgroundColor = color
        leading.constant = leftPadding
        trailing.constant = rightPadding
    }

    public static func getCell(height: CGFloat = 8, color: UIColor = .white, leftPadding: CGFloat = 0, rightPadding: CGFloat = 0) -> SeparatorCell {
        let cell = SeparatorCell.getCell(SeparatorCell.self)
        cell.configure(height: height, color: color, leftPadding: leftPadding, rightPadding: rightPadding)
        return cell
    }
}

public extension UITableViewCell {
    static func separatorLine(_ height: CGFloat = 1, _ color: UIColor = .lightGray, leading: CGFloat = 0, trailing: CGFloat = 0) -> UITableViewCell {
        return SeparatorCell.getCell(height: height, color: color, leftPadding: leading, rightPadding: trailing)
    }
    
    static func separator(_ height: CGFloat = 8, _ color: UIColor = .clear) -> UITableViewCell {
        return SeparatorCell.getCell(height: height, color: color)
    }
}






////--------------------------------------------------------------------------------------------------------------------------------------------------------------------
////  SeparatorCell.swift
////  MovieDB-v2
////
////  Created by Imran on 9/3/22.
////  Copyright © 2022 portonics. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//
//
//public class SeparatorCell: UITableViewCell, Reusable {
//
//     var mainView =  UIView()
//     var mainViewHeight: NSLayoutConstraint?
//     var leading: NSLayoutConstraint?
//     var trailing: NSLayoutConstraint?
//
////    public override func awakeFromNib() {
//////        super.awakeFromNib()
////        selectionStyle = .none
////        backgroundColor = .clear
////    }
//    public init(frame: CGRect) {
//        super.init(style: .default, reuseIdentifier: SeparatorCell.nibName)
//        addSubview(contentView)
//        contentView.fitToSuper()
//        contentView.addSubview(mainView)
//        mainView.fitToSuper()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    public func configure(height: CGFloat, color: UIColor = .white, leftPadding: CGFloat, rightPadding: CGFloat) {
//        mainViewHeight?.constant = height
//        mainView.backgroundColor = color
//        leading?.constant = leftPadding
//        trailing?.constant = rightPadding
//    }
//
//    public static func getCell(height: CGFloat = 8, color: UIColor = .white, leftPadding: CGFloat = 0, rightPadding: CGFloat = 0) -> SeparatorCell {
//        let cell = SeparatorCell.getCell(SeparatorCell.self)
//        cell.configure(height: height, color: color, leftPadding: leftPadding, rightPadding: rightPadding)
//        return cell
//    }
//}
//
//public extension UITableViewCell {
//    static func separatorLine(_ height: CGFloat = 1, _ color: UIColor = hexToUIColor(hex: "#E4E4E4"), leading: CGFloat = 0, trailing: CGFloat = 0) -> UITableViewCell {
//        return SeparatorCell.getCell(height: height, color: color, leftPadding: leading, rightPadding: trailing)
//    }
//
//    static func separator(_ height: CGFloat = 8, _ color: UIColor = .clear) -> UITableViewCell {
//        return SeparatorCell.getCell(height: height, color: color)
//    }
//}
//
////extension SeparatorCell: Configurable {
////    public func configure(model: SeparatorCellVM?) {
////        guard let model = model else {
////            return
////        }
////        configure(
////            height: model.height,
////            color: model.color,
////            leftPadding: model.leading,
////            rightPadding: model.trailling
////        )
////    }
////}
