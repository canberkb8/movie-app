//
//  MovieDetailViewController.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 22.10.2021.
//

import UIKit

protocol MovieDetailViewOutPut {
    func changeLoading(isLoad: Bool)
    func movieDetailData(isSuccess: Bool, error: Int?, data: MovieDetailResponseModel?)
}

class MovieDetailViewController: UIViewController {
    
    var movieDetailID = 0
    private var movieDetailViewModel: IMovieDetailViewModel = MovieDetailViewModel()
    lazy var loadingDialog = LoadingDialog()
    lazy var movieDetailView = MovieDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailViewModel.setDelegate(output: self)
        movieDetailViewModel.getMovieDetail(id: movieDetailID)
        configure()
    }
    
    private func configure() {
        drawDesign()
        makeMoviewDetailView()
    }

    private func drawDesign() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
        }
    }

}

extension MovieDetailViewController: MovieDetailViewOutPut {
    func changeLoading(isLoad: Bool) {
        if isLoad {
            loadingDialog.playAnimation()
            view.addSubview(loadingDialog)
        } else {
            loadingDialog.stopAnimation()
            loadingDialog.removeFromSuperview()
        }
    }
    
    func movieDetailData(isSuccess: Bool, error: Int?, data: MovieDetailResponseModel?) {
        if isSuccess {
            movieDetailView.setupView(model: movieDetailViewModel.movieDetailData!)
        } else {
            print(error!)
        }
    }
    
}

extension MovieDetailViewController{
    func makeMoviewDetailView(){
        view.addSubview(movieDetailView)
        movieDetailView.snp.makeConstraints { (make) -> Void in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
