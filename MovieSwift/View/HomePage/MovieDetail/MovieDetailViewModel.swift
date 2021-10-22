//
//  MovieDetailViewModel.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 22.10.2021.
//

import Alamofire
import ObjectMapper
import SwiftyJSON

protocol IMovieDetailViewModel {

    var movieDetailData: MovieDetailResponseModel? { get set }
    var movieDetailViewOutPut: MovieDetailViewOutPut? { get }

    func changeLoading()
    func setDelegate(output: MovieDetailViewOutPut)
    func getMovieDetail(id: Int)

}

final class MovieDetailViewModel: IMovieDetailViewModel {
    
    var movieDetailData: MovieDetailResponseModel? = nil
    private var isLoading = false
    var movieDetailViewOutPut: MovieDetailViewOutPut?

    func changeLoading() {
        isLoading = !isLoading
        movieDetailViewOutPut?.changeLoading(isLoad: isLoading)
    }

    func setDelegate(output: MovieDetailViewOutPut) {
        movieDetailViewOutPut = output
    }

    func getMovieDetail(id: Int) {
        changeLoading()
        ApiClient.GET(EndPoint.movieDetailPath(id: String(id)),
            success: { [weak self] data in
                let movieDetailResponse = Mapper<MovieDetailResponseModel>().map(JSONString: data.rawString()!)
                self?.movieDetailData = movieDetailResponse
                self?.movieDetailViewOutPut?.movieDetailData(isSuccess: true, error: nil, data: movieDetailResponse)
            }, done: {
                self.changeLoading()
            }, fail: { error in
                self.movieDetailViewOutPut?.movieDetailData(isSuccess: false, error: error, data: nil)
            }
        )
    }

}
