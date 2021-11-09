//
//  MoviesViewModel.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

import Alamofire
import ObjectMapper
import SwiftyJSON

protocol IMoviesViewModel {

    var moviesData: MovieResponseModel? { get set }
    var moviesViewOutPut: MoviesViewOutPut? { get }

    func changeLoading()
    func setDelegate(output: MoviesViewOutPut)
    func getMovie(endPoint: String)
    func getMovieNextPage(endPoint: String)

}

final class MoviesViewModel: IMoviesViewModel {
    var moviesData: MovieResponseModel? = nil
    private var isLoading = false
    var moviesViewOutPut: MoviesViewOutPut?

    func changeLoading() {
        isLoading = !isLoading
        moviesViewOutPut?.changeLoading(isLoad: isLoading)
    }

    func setDelegate(output: MoviesViewOutPut) {
        moviesViewOutPut = output
    }

    func getMovie(endPoint: String) {
        changeLoading()
        ApiClient.GET(endPoint,
            success: { [weak self] data in
                let moviesResponse = Mapper<MovieResponseModel>().map(JSONString: data.rawString()!)
                self?.moviesData = moviesResponse
                self?.moviesViewOutPut?.movieData(isSuccess: true, error: nil, data: self?.moviesData)
            }, done: {
                self.changeLoading()
            }, fail: { error in
                self.moviesViewOutPut?.movieData(isSuccess: false, error: error, data: nil)
            }
        )
    }

    func getMovieNextPage(endPoint: String) {
        ApiClient.GET(endPoint,
            success: { [weak self] data in
                let moviesResponse = Mapper<MovieResponseModel>().map(JSONString: data.rawString()!)
                self?.moviesData = moviesResponse
                self?.moviesViewOutPut?.movieData(isSuccess: true, error: nil, data: self?.moviesData)
            }, done: { },
            fail: { error in
                self.moviesViewOutPut?.movieData(isSuccess: false, error: error, data: nil)
            }
        )
    }

}
