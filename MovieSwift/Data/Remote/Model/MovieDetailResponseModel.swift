//
//  MovieDetailResponseModel.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 22.10.2021.
//

import Foundation
import ObjectMapper

struct MovieDetailResponseModel: Mappable {
    var adult: Bool?
    var backdrop_path: String?
    var belongs_to_collection: MovieDetailBelongsToCollection?
    var budget: Int?
    var genres: [MovieDetailGenres]?
    var homepage: String?
    var id: Int?
    var imdb_id: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var production_companies: [MovieDetailProductionCompanies]?
    var production_countries: [MovieDetailProductionCountries]?
    var release_date: String?
    var revenue: Int?
    var runtime: Int?
    var spoken_languages: [MovieDetailSpokenLanguages]?
    var status: String?
    var tagline: String?
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
        belongs_to_collection <- map["belongs_to_collection"]
        budget <- map["budget"]
        genres <- map["genres"]
        homepage <- map["homepage"]
        id <- map["id"]
        imdb_id <- map["imdb_id"]
        original_language <- map["original_language"]
        original_title <- map["original_title"]
        overview <- map["overview"]
        popularity <- map["popularity"]
        poster_path <- map["poster_path"]
        production_companies <- map["production_companies"]
        production_countries <- map["production_countries"]
        release_date <- map["release_date"]
        revenue <- map["revenue"]
        runtime <- map["runtime"]
        spoken_languages <- map["spoken_languages"]
        status <- map["status"]
        tagline <- map["tagline"]
        title <- map["title"]
        video <- map["video"]
        vote_average <- map["vote_average"]
        vote_count <- map["vote_count"]
    }

}


struct MovieDetailBelongsToCollection: Mappable {
    var id: Int?
    var name: String?
    var poster_path: String?
    var backdrop_path: String?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        poster_path <- map["poster_path"]
        backdrop_path <- map["backdrop_path"]
    }

}

struct MovieDetailGenres: Mappable {
    var id: Int?
    var name: String?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
    }

}

struct MovieDetailProductionCompanies: Mappable {
    var id: Int?
    var logo_path: String?
    var name: String?
    var origin_country: String?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        logo_path <- map["logo_path"]
        name <- map["name"]
        origin_country <- map["origin_country"]
    }

}

struct MovieDetailProductionCountries: Mappable {
    var iso_3166_1: String?
    var name: String?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {

        iso_3166_1 <- map["iso_3166_1"]
        name <- map["name"]
    }

}

struct MovieDetailSpokenLanguages: Mappable {
    var english_name: String?
    var iso_639_1: String?
    var name: String?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {

        english_name <- map["english_name"]
        iso_639_1 <- map["iso_639_1"]
        name <- map["name"]
    }

}

