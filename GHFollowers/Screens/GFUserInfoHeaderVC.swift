//
//  GFUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-20.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {

    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel(textAlignment: .left)
    var user: User!

    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        layoutUI()
        configureUIElements()
    }

    private func configureUIElements() {
        downloadAvatarImage()
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? "No name provided"
        locationLabel.text = user.location ?? "No location provided"
        bioLabel.text = user.bio ?? "No bio provided"
        bioLabel.numberOfLines = 3
        locationImageView.image = SFSymbols.location
        locationImageView.tintColor = .secondaryLabel
    }
    
    private func downloadAvatarImage() {
        NetworkManager.shared.downloadImage(from: user.avatarUrl) { [weak self](image) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
    }

    private func setupSubviews() {
        view.addSubviews(avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel)
    }

    private func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12

        avatarImageView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: nil,
            identifier: "GFUserInfoHeaderVC.avatarImageView.directionalAnchors",
            padding: .init(
                top: padding,
                left: padding,
                bottom: 0,
                right: 0
            )
        )
        avatarImageView.constrainWidthToConstant(90, identifier: "GFUserInfoHeaderVC.avatarImageView.widthConstraint")
        avatarImageView.constrainHeightToConstant(90, identifier: "GFUserInfoHeaderVC.avatarImageView.heightConstraint")

        usernameLabel.anchor(
            top: avatarImageView.topAnchor,
            leading: avatarImageView.trailingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            identifier: "GFUserInfoHeaderVC.usernameLabel.directionalAnchors",
            padding: .init(
                top: 0,
                left: textImagePadding,
                bottom: 0,
                right: padding
            )
        )
        usernameLabel.constrainHeightToConstant(38, identifier: "GFUserInfoHeaderVC.usernameLabel.heightConstraint")

        nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8).activate(withIdentifier: "GFUserInfoHeaderVC.nameLabel.centerYAnchor")
        nameLabel.anchor(
            top: nil,
            leading: avatarImageView.trailingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            identifier: "GFUserInfoHeaderVC.nameLabel.directionalAnchors",
            padding: .init(
                top: 0,
                left: textImagePadding,
                bottom: 0,
                right: padding
            )
        )
        nameLabel.constrainHeightToConstant(20, identifier: "GFUserInfoHeaderVC.nameLabel.heightConstraint")

        locationImageView.anchor(
            top: nil,
            leading: avatarImageView.trailingAnchor,
            bottom: avatarImageView.bottomAnchor,
            trailing: nil,
            identifier: "GFUserInfoHeaderVC.locationImageView.directionalAnchors",
            padding: .init(
                top: 0,
                left: textImagePadding,
                bottom: 0,
                right: 0
            )
        )
        locationImageView.constrainHeightToConstant(20, identifier: "GFUserInfoHeaderVC.locationImageView.heightConstraint")
        locationImageView.constrainWidthToConstant(20, identifier: "GFUserInfoHeaderVC.locationImageView.widthConstraint")

        locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor).activate(withIdentifier: "GFUserInfoHeaderVC.locationLabel.centerYAnchor")
        locationLabel.anchor(
            top: nil,
            leading: locationImageView.trailingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            identifier:  "GFUserInfoHeaderVC.locationLabel.directionalAnchors",
            padding: .init(
                top: 0,
                left: 5,
                bottom: 0,
                right: padding
            )
        )
        locationLabel.constrainHeightToConstant(20, identifier: "GFUserInfoHeaderVC.locationLabel.heightConstraint")

        bioLabel.anchor(
            top: avatarImageView.bottomAnchor,
            leading: avatarImageView.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            identifier: "GFUserInfoHeaderVC.bioLabel.directionalAnchors",
            padding: .init(
                top: textImagePadding,
                left: 0,
                bottom: 0,
                right: padding
            )
        )
        bioLabel.constrainHeightToConstant(90, identifier: "GFUserInfoHeaderVC.bioLabel.heightConstraint")
    }

}
