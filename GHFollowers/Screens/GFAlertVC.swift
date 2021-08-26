//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-18.
//

import UIKit

class GFAlertVC: UIViewController {
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    let padding: CGFloat = 20
    
    let containerView = GFAlertContainerView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")

    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    private func configureContainerView() {
        view.addSubview(containerView)
        
        containerView.centerYInSuperview(identifier: "GFAlertVC.containerView.centerYAnchor")
        containerView.centerXInSuperview(identifier: "GFAlertVC.containerView.centerXAnchor")
        containerView.constrainWidthToConstant(280, identifier: "GFAlertVC.containerView.widthAnchor")
        containerView.constrainHeightToConstant(220, identifier: "GFAlertVC.containerView.heightAnchor")
    }
    
    private func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        titleLabel.anchor(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            bottom: nil,
            trailing: containerView.trailingAnchor,
            identifier: "GFAlertVC.titleLabel.directionalAnchors",
            padding: .init(
                top: padding,
                left: padding,
                bottom: 0,
                right: padding)
        )
        titleLabel.constrainHeightToConstant(padding + 8, identifier: "GFAlertVC.titleLabel.heightAnchor")
    }
    
    private func configureActionButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        actionButton.anchor(
            top: nil,
            leading: containerView.leadingAnchor,
            bottom: containerView.bottomAnchor,
            trailing: containerView.trailingAnchor,
            identifier: "GFAlertVC.actionButton.directionalAnchors",
            padding: .init(
                top: 0,
                left: padding,
                bottom: padding,
                right: padding)
        )
        actionButton.constrainHeightToConstant(44, identifier: "GFAlertVC.actionButton.heightAnchor")
    }
    
    private func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        messageLabel.anchor(
            top: titleLabel.topAnchor,
            leading: containerView.leadingAnchor,
            bottom: actionButton.topAnchor,
            trailing: containerView.trailingAnchor,
            identifier: "GFAlertVC.messageLabel.directionalAnchors",
            padding: .init(
                top: 8,
                left: padding,
                bottom: 12,
                right: padding)
        )
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
}
