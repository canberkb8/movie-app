//
//  EndPoint.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

enum EndPoint: String {
    case BASE_URL = "https://api.themoviedb.org/3/"
    case MOVIE_POPULAR = "movie/popular"

    static func moviePopularPath() -> String {
        return "\(BASE_URL.rawValue)\(MOVIE_POPULAR.rawValue)"
    }
}
