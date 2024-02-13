//
//  Color+Ext.swift
//  NTI
//
//  Created by Viktoria Lobanova on 10.02.2024.
//

import UIKit

extension UIColor {
    static let background = BackgroundColor()
    static let fontColor = FontColor()
}

struct BackgroundColor {
    let grayNTI = UIColor(named: "grayNTI")
    let blackNTI = UIColor(named: "blackNTI")
    let selectedCell = UIColor(named: "blueNTI")
    let blueNTI = UIColor(named: "blueNTI")
    let unselectedCell = UIColor(named: "unselectedCell")
}

struct FontColor {
    let whiteNTI = UIColor(named: "whiteNTI")
    let blackNTI = UIColor(named: "blackNTI")
    let yellowNTI = UIColor(named: "yellowNTI")
    let lightGrayNTI = UIColor(named: "lightGrayNTI")
    let redNTI = UIColor(named: "redNTI")
}
