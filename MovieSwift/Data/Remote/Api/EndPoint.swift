//
//  EndPoint.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

enum EndPoint: String {
    case BASE_URL = "https://api.themoviedb.org/3/"
    
    case IMAGE_SMALL = "https://image.tmdb.org/t/p/w154"
    case IMAGE_MEUDIUM = "https://image.tmdb.org/t/p/w500"
    case IMAGE_CAST = "https://image.tmdb.org/t/p/w185"
    case IMAGE_ORIGINAL = "https://image.tmdb.org/t/p/original"
    
    case MOVIE_POPULAR = "movie/popular"

    static func smallImagePath(url:String) -> String{
        return "\(IMAGE_SMALL.rawValue)\(url)"
    }
    static func mediumImagePath(url:String) -> String{
        return "\(IMAGE_MEUDIUM.rawValue)\(url)"
    }
    static func castImagePath(url:String) -> String{
        return "\(IMAGE_CAST.rawValue)\(url)"
    }
    static func originalImagePath(url:String) -> String{
        return "\(IMAGE_ORIGINAL.rawValue)\(url)"
    }
    static func moviePopularPath() -> String {
        return "\(BASE_URL.rawValue)\(MOVIE_POPULAR.rawValue)"
    }
}
