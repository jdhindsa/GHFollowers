//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-23.
//

import UIKit

enum  ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
    
    private func configure() {
        addSubviews(symbolImageView, titleLabel, countLabel)
        
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        symbolImageView.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: nil,
            identifier: "GFItemInfoView.symbolImageView.directionalAnchors"
        )
        symbolImageView.constrainWidthToConstant(20, identifier: "GFItemInfoView.symbolImageView.widthAnchor")
        symbolImageView.constrainHeightToConstant(20, identifier: "GFItemInfoView.symbolImageView.heightAnchor")
        titleLabel.centerYAnchorWithElement(symbolImageView.centerYAnchor, identifier: "GFItemInfoView.titleLabel.centerYAnchor")
        
        titleLabel.anchor(
            top: nil,
            leading: symbolImageView.trailingAnchor,
            bottom: nil,
            trailing: self.trailingAnchor,
            identifier: "GFItemInfoView.titleLabel.directionalAnchors",
            padding: .init(
                top: 0,
                left: 12,
                bottom: 0,
                right: 0
            )
        )
        titleLabel.constrainHeightToConstant(18, identifier: "GFItemInfoView.titleLabel.heightAnchor")
        
        countLabel.anchor(
            top: symbolImageView.bottomAnchor,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: self.trailingAnchor,
            identifier: "GFItemInfoView.countLabel.directionalAnchors",
            padding: .init(
                top: 4,
                left: 0,
                bottom: 0,
                right: 0
            )
        )
        countLabel.constrainHeightToConstant(18, identifier: "GFItemInfoView.countLabel.heightAnchor")
    }
}
