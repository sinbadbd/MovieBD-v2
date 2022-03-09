//
//  UIView+UIStackView.swift
//  MyTelenor
//
//  Created by Nazim Uddin on 8/26/20.
//  Copyright © 2020 Portonics. All rights reserved.
//

import UIKit

extension UIView {
    
    fileprivate func Stack(_ axis: NSLayoutConstraint.Axis = .vertical, views: [UIView], spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis  = axis
        stackView.spacing   = spacing
        stackView.alignment = alignment
        stackView.distribution  = distribution
        addSubview(stackView)
        return stackView
    }
    
    @discardableResult
    open func VStack(_ views: UIView..., spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        return Stack(.vertical, views: views, spacing: spacing, alignment: alignment, distribution: distribution)
    }
    
    @discardableResult
    open func HStack(_ views: UIView..., spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        return Stack(.horizontal, views: views, spacing: spacing, alignment: alignment, distribution: distribution)
    }
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }

}

func shadowForViewLight(shadow:UIView) {
    shadow.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
    shadow.layer.shadowOffset = CGSize(width: 0,height: 1.75)
    shadow.layer.shadowRadius = 1.7
    shadow.layer.shadowOpacity = 0.2
}
