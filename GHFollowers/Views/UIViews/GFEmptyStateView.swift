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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configure() {
        addSubviews(messageLabel, logoImageView)
        anchorMessageLabel()
        anchorLogoImageView()
    }
    
    private func anchorMessageLabel() {
        messageLabel.numberOfLines = DeviceTypes.isiPhoneSEOriPhone8Zoomed() ? 4 : 3
        messageLabel.textColor = .secondaryLabel
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSEOriPhone8Zoomed() ? 80 : 150
        messageLabel.centerYInSuperview(shiftAboveCenterY: labelCenterYConstant, identifier: "GFEmptyStateView.messageLabel.centerYAnchor")
        messageLabel.anchor(
            top: nil,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: self.trailingAnchor                       ,
            identifier: "GFEmptyStateView.messageLabel.centerYAnchor",
            padding: .init(
                top: 0,
                left: 40,
                bottom: 0,
                right: 40
            )
        )
        messageLabel.constrainHeightToConstant(200, identifier: "GFEmptyStateView.messageLabel.heightAnchor")

    }
    
    private func anchorLogoImageView() {
        logoImageView.image = Images.emptyStateLogo
        logoImageView.contentMode = .scaleAspectFit
        let logoImageViewBottomConstant: CGFloat = DeviceTypes.isiPhoneSEOriPhone8Zoomed() ? -85 : -40
        logoImageView.anchorAsSquareWithMatchingWidthAndHeightAnchors(multiplier: 1.3, identifier: "GFEmptyStateView.logoImageView.squareDimensionsAnchor")
        logoImageView.anchor(
            top: nil,
            leading: nil,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor,
            identifier: "GFEmptyStateView.logoImageView.directionalAnchors",
            padding: .init(
                top: 0,
                left: 0,
                bottom: logoImageViewBottomConstant,
                right: -170
            )
        )
    }
}
