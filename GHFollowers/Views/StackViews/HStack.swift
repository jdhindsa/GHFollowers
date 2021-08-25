//
//  HStack.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-23.
//

import UIKit

class HStack: UIStackView {
    init() {
        super.init(frame: .zero)
    }
    
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0, distribution: UIStackView.Distribution = .equalSpacing) {
        super.init(frame: .zero)
        configureStackView(arrangedSubviews: arrangedSubviews, spacing: spacing, distribution: distribution)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(arrangedSubviews: [UIView], spacing: CGFloat = 0, distribution: UIStackView.Distribution = .equalSpacing) {
        configureStackView(arrangedSubviews: arrangedSubviews, spacing: spacing, distribution: distribution)
    }
    
    private func configureStackView(arrangedSubviews: [UIView], spacing: CGFloat = 0, distribution: UIStackView.Distribution = .equalSpacing) {
        arrangedSubviews.forEach({addArrangedSubview($0)})
        self.spacing = spacing
        self.axis = .horizontal
        self.distribution = distribution
    }
}
