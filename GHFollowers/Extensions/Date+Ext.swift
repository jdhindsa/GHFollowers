//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-23.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
