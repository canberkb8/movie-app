//
//  PopularMovieResponseModel.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

import Foundation
import ObjectMapper

struct PopularMovieResponseModel: Mappable {
    var page: Int?
    var results: [PopularMovieResults]?
    var total_pages: Int?
    var total_results: Int?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {

        page <- map["page"]
        results <- map["results"]
        total_pages <- map["total_pages"]
        total_results <- map["total_results"]
    }

}

struct PopularMovieResults: Mappable {
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {

        adult <- map["adult"]
        backdrop_path <- map["backdrop_path"]
        genre_ids <- map["genre_ids"]
        id <- map["id"]
        original_language <- map["original_language"]
        original_title <- map["original_title"]
        overview <- map["overview"]
        popularity <- map["popularity"]
        poster_path <- map["poster_path"]
        release_date <- map["release_date"]
        title <- map["title"]
        video <- map["video"]
        vote_average <- map["vote_average"]
        vote_count <- map["vote_count"]
    }

}
