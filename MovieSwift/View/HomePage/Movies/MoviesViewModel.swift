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

    var popularMoviesData: PopularMovieResponseModel? { get set }
    var moviesViewOutPut: MoviesViewOutPut? { get }

    func changeLoading()
    func setDelegate(output: MoviesViewOutPut)
    func getPopularMovies()

}

final class MoviesViewModel: IMoviesViewModel {
    
    var popularMoviesData: PopularMovieResponseModel? = nil
    private var isLoading = false
    var moviesViewOutPut: MoviesViewOutPut?

    func changeLoading() {
        isLoading = !isLoading
        moviesViewOutPut?.changeLoading(isLoad: isLoading)
    }

    func setDelegate(output: MoviesViewOutPut) {
        moviesViewOutPut = output
    }

    func getPopularMovies() {
        changeLoading()
        ApiClient.GET(EndPoint.moviePopularPath(),
            success: { [weak self] data in
                let popularMoviesResponse = Mapper<PopularMovieResponseModel>().map(JSONString: data.rawString()!)
                self?.popularMoviesData = popularMoviesResponse
                self?.moviesViewOutPut?.popularMovieData(isSuccess: true, error: nil, data: self?.popularMoviesData)
            }, done: {
                self.changeLoading()
            }, fail: { error in
                self.moviesViewOutPut?.popularMovieData(isSuccess: false, error: error, data: nil)
            }
        )
    }

}
