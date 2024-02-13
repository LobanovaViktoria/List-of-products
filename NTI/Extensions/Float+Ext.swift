//
//  Float+Ext.swift
//  NTI
//
//  Created by Viktoria Lobanova on 13.02.2024.
//

import Foundation

extension Float {
    var asRUBCurrency: String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₽"
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
