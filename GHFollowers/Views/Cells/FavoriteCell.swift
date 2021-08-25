//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-24.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Follower) {
        usernameLabel.text = favorite.login
        NetworkManager.shared.downloadImage(from: favorite.avatarUrl) { [weak self](image) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        accessoryType = .disclosureIndicator
        
        avatarImageView.centerYInSuperview(identifier: "FavoriteCell.avatarImageView.centerY")
        avatarImageView.anchor(
            top: nil,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: nil,
            identifier: "FavoriteCell.avatarImageView.directionalAnchors",
            padding: .init(
                top: 0,
                left: 12,
                bottom: 0,
                right: 0
            )
        )
        avatarImageView.anchorAsSquareWithMatchingWidthAndHeightConstants(constant: 60, identifier: "FavoriteCell.avatarImageView.widthAndHeightAnchors")
        
        usernameLabel.centerYInSuperview(identifier: "FavoriteCell.usernameLabel.centerY")
        usernameLabel.anchor(
            top: nil,
            leading: avatarImageView.trailingAnchor,
            bottom: nil,
            trailing: self.trailingAnchor,
            identifier: "FavoriteCell.usernameLabel.directionalAnchors",
            padding: .init(
                top: 0,
                left: 24,
                bottom: 0,
                right: 12
            )
        )
        usernameLabel.constrainHeightToConstant(40, identifier: "FavoriteCell.usernameLabel.heightAnchor")
    }
}
