//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-23.
//

import UIKit

class GFItemInfoVC: UIViewController {
    
    let stackView = HStack()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()
    var user: User!
    weak var delegate: UserInfoVCDelegate!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
        configureActionButton()
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.setup(arrangedSubviews: [itemInfoViewOne])
        stackView.setup(arrangedSubviews: [itemInfoViewTwo])
    }
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() {
        // This is empty because we will override this method in the subclass.
    }
    
    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            identifier: "GFItemInfoVC.stackView.directionalAnchors",
            padding: .init(
                top: 20,
                left: 20,
                bottom: 0,
                right: 20
            )
        )
        stackView.constrainHeightToConstant(50, identifier: "GFItemInfoVC.stackView.heightAnchor")

        actionButton.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            identifier: "GFItemInfoVC.actionButton.directionalAnchors",
            padding: .init(
                top: 0,
                left: 20,
                bottom: 20,
                right: 20
            )
        )
        actionButton.constrainHeightToConstant(44, identifier: "GFItemInfoVC.actionButton.heightAnchor")
    }
}
