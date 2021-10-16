//
//  UIColor.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

import UIKit

extension UIColor {

    static let goldYellow = UIColor(rgb: 0xD5AD36)

    struct ratingColors {
        static let highRed = UIColor(rgb: 0xB60A1C)
        static let middleRed = UIColor(rgb: 0xE03531)
        static let lowRed = UIColor(rgb: 0xFF684C)
        static let highYellow = UIColor(rgb: 0xE39802)
        static let middleYellow = UIColor(rgb: 0xF0BD27)
        static let lowYellow = UIColor(rgb: 0xFFDA66)
        static let highGreen = UIColor(rgb: 0x309143)
        static let middleGreen = UIColor(rgb: 0x51B364)
        static let lowGreen = UIColor(rgb: 0x8ACE7E)
    }
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
