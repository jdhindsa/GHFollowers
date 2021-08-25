//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-18.
//

import UIKit

extension UIView {
    @discardableResult
    func anchor(
        top: NSLayoutYAxisAnchor?,
        leading: NSLayoutXAxisAnchor?,
        bottom: NSLayoutYAxisAnchor?,
        trailing: NSLayoutXAxisAnchor?,
        identifier: String,
        padding: UIEdgeInsets = .zero,
        size: CGSize = .zero) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        let constraintsArr: [NSLayoutConstraint?] = [
            anchoredConstraints.top,
            anchoredConstraints.leading,
            anchoredConstraints.bottom,
            anchoredConstraints.trailing,
            anchoredConstraints.width,
            anchoredConstraints.height
        ]
        constraintsArr.forEach {
            $0?.activate(withIdentifier: identifier)
        }
        return anchoredConstraints
    }
    
    func centerYAnchorWithElement(_ elementYAnchor: NSLayoutYAxisAnchor?, identifier: String) {
        translatesAutoresizingMaskIntoConstraints = false
        if let elementYAnchor = elementYAnchor {
            centerYAnchor.constraint(equalTo: elementYAnchor).activate(withIdentifier: identifier)
        }
    }
    
    func centerXAnchorWithElement(_ elementXAnchor: NSLayoutXAxisAnchor?, identifier: String) {
        translatesAutoresizingMaskIntoConstraints = false
        if let elementXAnchor = elementXAnchor {
            centerXAnchor.constraint(equalTo: elementXAnchor).activate(withIdentifier: identifier)
        }
    }

    func anchorAsSquareWithMatchingWidthAndHeightAnchors(multiplier: CGFloat = 1.0, identifier: String) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewWidthAnchor = superview?.widthAnchor {
            heightAnchor.constraint(equalTo: superviewWidthAnchor, multiplier: multiplier).activate(withIdentifier: identifier)
        }
    }
    
    func anchorAsSquareWithMatchingWidthAndHeightConstants(constant: CGFloat, identifier: String) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).activate(withIdentifier: identifier)
        widthAnchor.constraint(equalToConstant: constant).activate(withIdentifier: identifier)
    }

    func fillSuperview(identifier: String, padding: UIEdgeInsets = .zero)  {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).activate(withIdentifier: identifier)
        }
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).activate(withIdentifier: identifier)
        }
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).activate(withIdentifier: identifier)
        }
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).activate(withIdentifier: identifier)
        }
    }

    func centerInSuperview(identifier: String, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).activate(withIdentifier: identifier)
        }
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).activate(withIdentifier: identifier)
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).activate(withIdentifier: identifier)
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).activate(withIdentifier: identifier)
        }
    }

    func centerXInSuperview(shiftLeftCenterX: CGFloat = 0, shiftRightCenterX: CGFloat = 0, identifier: String) {
        translatesAutoresizingMaskIntoConstraints = false
        var offset: CGFloat = 0
        if shiftLeftCenterX > 0 {
            offset = shiftLeftCenterX * -1
        } else if shiftRightCenterX > 0 {
            offset = shiftRightCenterX
        } else if shiftLeftCenterX > 0 && shiftRightCenterX > 0 {
            // If both parameters were set to a value, then that must be a mistake and the offset is 0.
            offset = 0
        }
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor, constant: offset).isActive = true
        }
    }

    func centerYInSuperview(shiftAboveCenterY: CGFloat = 0, shiftBelowCenterY: CGFloat = 0, identifier: String) {
        translatesAutoresizingMaskIntoConstraints = false
        var offset: CGFloat = 0
        if shiftAboveCenterY > 0 {
            offset = shiftAboveCenterY * -1
        } else if shiftBelowCenterY > 0 {
            offset = shiftBelowCenterY
        } else if shiftAboveCenterY > 0 && shiftBelowCenterY > 0 {
            // If both parameters were set to a value, then that must be a mistake and the offset is 0.
            offset = 0
        }
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY, constant: offset).activate(withIdentifier: identifier)
        }
    }

    func constrainWidthToConstant(_ constant: CGFloat, identifier: String) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).activate(withIdentifier: identifier)
    }

    func constrainHeightToConstant(_ constant: CGFloat, identifier: String) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).activate(withIdentifier: identifier)
    }

    func constrainWidthAnchor(multiplier: CGFloat = 0, identifier: String) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewWidthAnchor = superview?.widthAnchor {
            widthAnchor.constraint(equalTo: superviewWidthAnchor, multiplier: multiplier).activate(withIdentifier: identifier)
        }
    }
    
    func constrainHeightAnchor(multiplier: CGFloat = 0, identifier: String) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewHeightAnchor = superview?.heightAnchor {
            heightAnchor.constraint(equalTo: superviewHeightAnchor, multiplier: multiplier).activate(withIdentifier: identifier)
        }
    }
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height, centerX, centerY: NSLayoutConstraint?
}
