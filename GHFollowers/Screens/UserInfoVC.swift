//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-20.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: GFDataLoadingVC {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var username: String!
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    weak var delegate: UserInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureScrollView()
        layoutUI()
        fetchUserInfo()
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func fetchUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self](result) in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "I don't know what happened!?!? 🤯", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func configureScrollView() {
        view.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        scrollView.fillSuperview(identifier: "UserInfoVC.scrollView.fillSuperview")
        contentView.fillSuperview(identifier: "UserInfoVC.contentView.fillSuperview")
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).activate(withIdentifier: "UserInfoVC.contentView.widthAnchor")
        contentView.heightAnchor.constraint(equalToConstant: 600).activate(withIdentifier: "UserInfoVC.contentView.heightAnchor")
    }
    
    private func configureUIElements(with user: User) {
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        self.dateLabel.text = "GitHubber since: \(user.createdAt.convertToMonthYearFormat())"
    }
    
    private func layoutUI() {
        contentView.addSubviews(headerView, itemViewOne, itemViewTwo, dateLabel)
        configureHeaderView()
        configureItemViewOne()
        configureItemViewTwo()
        configureDateLabel()
    }
    
    private func configureHeaderView() {
        headerView.backgroundColor = .white
        headerView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: nil,
            trailing: contentView.trailingAnchor,
            identifier: "UserInfoVC.headerView.directionalAnchors",
            padding: .init(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0
            )
        )
        headerView.constrainHeightToConstant(210, identifier: "UserInfoVC.headerView.heightConstraint")
    }

    private func configureItemViewOne() {
        itemViewOne.anchor(
            top: headerView.bottomAnchor,
            leading: headerView.leadingAnchor,
            bottom: nil,
            trailing: headerView.trailingAnchor,
            identifier: "UserInfoVC.itemViewOne.directionalAnchors",
            padding: .init(
                top: 20,
                left: 20,
                bottom: 0,
                right: 20
            )
        )
        itemViewOne.constrainHeightToConstant(140, identifier: "UserInfoVC.itemViewOne.heightAnchor")
    }

    private func configureItemViewTwo() {
        itemViewTwo.anchor(
            top: itemViewOne.bottomAnchor,
            leading: headerView.leadingAnchor,
            bottom: nil,
            trailing: headerView.trailingAnchor,
            identifier: "UserInfoVC.itemViewOne.directionalAnchors",
            padding: .init(
                top: 20,
                left: 20,
                bottom: 0,
                right: 20
            )
        )
        itemViewTwo.constrainHeightToConstant(140, identifier: "UserInfoVC.itemViewOne.heightAnchor")
    }
    
    private func configureDateLabel() {
        dateLabel.anchor(
            top: itemViewTwo.bottomAnchor,
            leading: nil,
            bottom: nil,
            trailing: nil,
            identifier: "UserInfoVC.dateLabel.directionalAnchors",
            padding: .init(
                top: 20,
                left: 0,
                bottom: 0,
                right: 0
            )
        )
        dateLabel.constrainHeightToConstant(50, identifier: "UserInfoVC.dateLabel.heightAnchor")
        dateLabel.centerXAnchorWithElement(itemViewTwo.centerXAnchor, identifier: "UserInfoVC.dateLabel.centerXAnchor")
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
}

extension UserInfoVC: GFRepoItemVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "OK")
            return
        }
        presentSafariVC(with: url)
    }
}

extension UserInfoVC: GFFollowItemVCDelegate {
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers, what a shame 😭", buttonTitle: "So Sad!")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
