//
//  String.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

import Foundation

extension String {
    func maxLength(length: Int) -> String {
        var str = self
        let nsString = str as NSString
        if nsString.length >= length {
            str = nsString.substring(with:
                    NSRange(
                    location: 0,
                    length: nsString.length > length ? length : nsString.length)
            )
        }
        return str
    }
}
