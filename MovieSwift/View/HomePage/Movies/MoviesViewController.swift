//
//  MoviesViewController.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

import UIKit

protocol MoviesViewOutPut {
    func changeLoading(isLoad: Bool)
    func popularMovieData(isSuccess: Bool, error: Int?, data: PopularMovieResponseModel?)
}

class MoviesViewController: UIViewController {

    private var moviesViewModel: IMoviesViewModel = MoviesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        moviesViewModel.setDelegate(output: self)
        moviesViewModel.getPopularMovies()

        configure()
    }

    private func configure() {
        drawDesign()
    }

    private func drawDesign() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
        }
    }

}

extension MoviesViewController: MoviesViewOutPut {
    func popularMovieData(isSuccess: Bool, error: Int? = nil, data: PopularMovieResponseModel? = nil) {
        if isSuccess {
            print(data!)
        } else {
            print(error!)
        }
    }

    func changeLoading(isLoad: Bool) {
        if isLoad {
            print("loading anim play")
        } else {
            print("loading anim stop")
        }
    }
}
