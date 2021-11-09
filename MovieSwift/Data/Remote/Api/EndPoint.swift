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

    case MOVIE = "movie"
    case MOVIE_POPULAR = "movie/popular"
    case MOVIE_TOPRATED = "movie/top_rated"
    case MOVIE_UPCOMING = "movie/upcoming"
    case MOVIE_NOWPLAY = "movie/now_playing"
    
    case SEARCH_MOVIE = "search/movie"

    static func smallImagePath(url: String) -> String {
        return "\(IMAGE_SMALL.rawValue)\(url)"
    }
    static func mediumImagePath(url: String) -> String {
        return "\(IMAGE_MEUDIUM.rawValue)\(url)"
    }
    static func castImagePath(url: String) -> String {
        return "\(IMAGE_CAST.rawValue)\(url)"
    }
    static func originalImagePath(url: String) -> String {
        return "\(IMAGE_ORIGINAL.rawValue)\(url)"
    }
    static func moviePopularPath(page: String) -> String {
        return "\(BASE_URL.rawValue)\(MOVIE_POPULAR.rawValue)\("?page=")\(page)"
    }
    static func movieTopRatedPath(page: String) -> String {
        return "\(BASE_URL.rawValue)\(MOVIE_TOPRATED.rawValue)\("?page=")\(page)"
    }
    static func movieUpComingPath(page: String) -> String {
        return "\(BASE_URL.rawValue)\(MOVIE_UPCOMING.rawValue)\("?page=")\(page)"
    }
    static func movieNowPlayPath(page: String) -> String {
        return "\(BASE_URL.rawValue)\(MOVIE_NOWPLAY.rawValue)\("?page=")\(page)"
    }
    static func movieDetailPath(id: String) -> String {
        return "\(BASE_URL.rawValue)\(MOVIE.rawValue)\("/")\(id)"
    }
    static func searchMoviePath(query: String, page: String) -> String {
        return "\(BASE_URL.rawValue)\(SEARCH_MOVIE.rawValue)\("?query=")\"\(query)\"\("&page=")\(page)"
    }
}
