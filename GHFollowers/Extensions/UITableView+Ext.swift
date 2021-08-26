//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-26.
//

import UIKit

extension UITableView {
    func removeExcessCells() {
        tableFooterView = UIView()
    }
    
    func reloadDataOnMainThread(shouldBringSubviewToFront: Bool = false, view: UIView? = nil) {
        DispatchQueue.main.async {
            self.reloadData()
            if shouldBringSubviewToFront {
                view?.bringSubviewToFront(self)
            }
        }
    }
}
