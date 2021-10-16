//
//  ApiClient.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class ApiClient: NSObject {

    class func getAccessToken() -> String {
        return "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYjRjZDVjZmZlZjFmNjQ0MDhmNTBhNjQ4ZDdkZjNkNiIsInN1YiI6IjYxNmFiMDAxNmY1M2UxMDA0MzQzMjFkNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vJ2CzD48M2j99UovBskWZhIbnBzZQD01oBropc8fIKg"
    }

    class func headers() -> HTTPHeaders {
        return ["Authorization": ("Bearer " + (getAccessToken())),
            "Content-Type": "application/json",
            "Accept": "application/json"]
    }

    class func GET(_ url: String, success: @escaping (JSON) -> Void
        , done: @escaping () -> Void = { }, fail: @escaping (Int) -> Void = { _ in }) {
        if Connectivity.isConnectedToInternet {
            AF.request(url, encoding: JSONEncoding.default, headers: headers())
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                switch response.result {
                case .success:
                    let resJson = JSON(response.value!)
                    success(resJson)
                case .failure(let error):
                    fail(error.responseCode ?? 0)
                }
                done()
            }
        } else {
            fail(502)
            done()
        }
    }

    class func POST(_ url: String, params: Parameters, success: @escaping (JSON) -> Void, done: @escaping () -> Void = { }, fail: @escaping (Int) -> Void = { _ in }) {
        if Connectivity.isConnectedToInternet {
            AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers())
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                switch response.result {
                case .success:
                    let resJson = JSON(response.value!)
                    success(resJson)
                case .failure(let error):
                    fail(error.responseCode ?? 0)
                }
                done()
            }
        } else {
            fail(502)
            done()
        }
    }

    struct Connectivity {
        static let sharedInstance = NetworkReachabilityManager()!
        static var isConnectedToInternet: Bool {
            return self.sharedInstance.isReachable
        }
    }
}
