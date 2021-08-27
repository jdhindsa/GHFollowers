//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-16.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let ctaButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    var isUsernameEntered: Bool {
        guard let enteredText = usernameTextField.text else { return false }
        return !enteredText.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureUsernameTextField()
        configureCTAButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc private func pushFollowerListVC() {
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username.  We need to know who to look for 😇", buttonTitle: "OK")
            return
        }
        usernameTextField.resignFirstResponder()
        guard let username = usernameTextField.text else { return }
        let followerListVC = FollowerListVC(username: username)
        navigationController?.pushViewController(followerListVC, animated: true)
        usernameTextField.text?.removeAll()
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.image = Images.ghLogo
        
        logoImageView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: nil,
            identifier: "SearchVC.logoImageView.topAnchor",
            padding: .init(
                top: DeviceTypes.isiPhoneSEOriPhone8Zoomed() ? 20 : 80,
                left: 0,
                bottom: 0,
                right: 0)
        )
        logoImageView.centerXInSuperview(identifier: "SearchVC.logoImageView.centerXInSuperview")
        logoImageView.constrainHeightToConstant(200, identifier: "SearchVC.logoImageView.heightAnchor")
        logoImageView.constrainWidthToConstant(200, identifier: "SearchVC.logoImageView.widthAnchor")
    }
    
    private func configureUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        usernameTextField.anchor(
            top: logoImageView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            identifier: "SearchVC.usernameTextField.directionalAnchors",
            padding: .init(
                top: 48,
                left: 50,
                bottom: 0,
                right: 50)
        )
        usernameTextField.constrainHeightToConstant(50, identifier: "SearchVC.usernameTextField.heightAnchor")
    }
    
    private func configureCTAButton() {
        view.addSubview(ctaButton)
        ctaButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)

        ctaButton.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            identifier: "SearchVC.ctaButton.directionalAnchors",
            padding: .init(
                top: 0,
                left: 50,
                bottom: 50,
                right: 50)
        )
        ctaButton.constrainHeightToConstant(50, identifier: "SearchVC.ctaButton.heightAnchor")
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
