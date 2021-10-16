//
//  Int.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

extension Int {
    func of(_ name: String) -> String {
        guard self != 1 else { return "\(self) \(name)" }
        return "\(self) \(name)s"
    }
}
