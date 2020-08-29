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
