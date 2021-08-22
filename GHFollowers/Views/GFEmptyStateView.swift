//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-19.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // Used if you are implementing the UIButton using a Storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        logoImageView.image = UIImage(named: "empty-state-logo")
        logoImageView.contentMode = .scaleAspectFit
        
        messageLabel.centerYInSuperview(shiftAboveCenterY: 150, identifier: "GFEmptyStateView.messageLabel.centerYAnchor")
        messageLabel.anchor(
            top: nil,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: self.trailingAnchor                       ,
            identifier: "GFEmptyStateView.centerY.anchor",
            padding: .init(
                top: 0,
                left: 40,
                bottom: 0,
                right: 40
            )
        )
        messageLabel.constrainHeightToConstant(200, identifier: "GFEmptyStateView.messageLabel.heightAnchor")
        logoImageView.anchorWithSquareDimensions(multiplier: 1.3, identifier: "GFEmptyStateView.logoImageView.squareDimensionsAnchor")
        logoImageView.anchor(
            top: nil,
            leading: nil,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor,
            identifier: "GFEmptyStateView.logoImageView.directionalAnchors",
            padding: .init(
                top: 0,
                left: 0,
                bottom: -40,
                right: -170
            )
        )
    }
}
