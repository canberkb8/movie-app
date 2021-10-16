//
//  Util.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

import UIKit

class Utils {

    func getAppversionNumber() -> String? {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return appVersion
    }

    func defaultAlertDialog(message: String) -> UIViewController {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style {
            case .default:
                break
            case .cancel:
                break
            case .destructive:
                break
            @unknown default:
                fatalError()
            }
        }))
        return alert
    }

    func getStringToDate(date: String) -> String? {
        let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: date)!
        formatter.dateFormat = "dd"
        let day = formatter.string(from: date)
        formatter.dateFormat = "MM"
        let month = months[Int(formatter.string(from: date))! - 1]
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        return day + " " + month + " " + year
    }
}
