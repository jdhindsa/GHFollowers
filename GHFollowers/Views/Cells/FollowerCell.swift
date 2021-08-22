//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-18.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        avatarImageView.contentMode = .scaleAspectFit
        
        avatarImageView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: nil,
            trailing: contentView.trailingAnchor,
            identifier: "FollowerCell.avatarImageView.directionalAnchors"
            , padding: .init(
                top: padding,
                left: padding,
                bottom: 0,
                right: padding)
        )
        
        avatarImageView.anchorWithSquareDimensions(identifier: "FollowerCell.avatarImageView.heightAndWidthAnchor")
        
        usernameLabel.anchor(
            top: avatarImageView.bottomAnchor,
            leading: contentView.leadingAnchor,
            bottom: nil,
            trailing: contentView.trailingAnchor,
            identifier: "FollowerCell.usernameLabel.directionalAnchors"
            , padding: .init(
                top: 12,
                left: padding,
                bottom: 0,
                right: 12)
        )
        
        usernameLabel.constrainHeightToConstant(20, identifier: "FollowerCell.usernameLabel.heightAnchor")
    }
}
