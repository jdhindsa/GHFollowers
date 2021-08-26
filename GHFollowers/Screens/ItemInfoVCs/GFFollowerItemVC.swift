//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-23.
//

import UIKit

protocol GFFollowItemVCDelegate: class {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
    
    weak var delegate: GFFollowItemVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    init(user: User, delegate: GFFollowItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
