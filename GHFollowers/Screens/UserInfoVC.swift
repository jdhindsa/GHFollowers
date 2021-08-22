//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-20.
//

// LEFT OFF AT 31:39 PLAYED OF "Child View Controller - UserInfoHeaderVC"

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!
    let headerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        layoutUI()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self](result) in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                print(user)
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "I don't know what happened!?!? 🤯", message: error.rawValue, buttonTitle: "OK")
            }
        }
        print(username!)
    }
    
    private func layoutUI() {
        view.addSubview(headerView)
        headerView.backgroundColor = .white
        headerView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leadingAnchor,
            bottom: nil,
            trailing: view.safeAreaLayoutGuide.trailingAnchor,
            identifier: "UserInfoVC.headerView.directionalAnchors",
            padding: .init(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0
            )
        )
        headerView.constrainHeightToConstant(180, identifier: "UserInfoVC.headerView.heightConstraint")
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
