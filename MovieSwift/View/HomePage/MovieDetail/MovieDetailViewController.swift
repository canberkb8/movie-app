//
//  MovieDetailViewController.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 22.10.2021.
//

import UIKit
import Awesome

protocol MovieDetailViewOutPut {
    func changeLoading(isLoad: Bool)
    func movieDetailData(isSuccess: Bool, error: Int?, data: MovieDetailResponseModel?)
}

final class MovieDetailViewController: UIViewController, UINavigationBarDelegate, UINavigationControllerDelegate {

    var movieDetailID = 0
    private var movieDetailViewModel: IMovieDetailViewModel = MovieDetailViewModel()
    lazy var loadingDialog = LoadingDialog()
    lazy var movieDetailView = MovieDetailView()
    lazy var backButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailViewModel.setDelegate(output: self)
        movieDetailViewModel.getMovieDetail(id: movieDetailID)
        configure()
    }

    @objc func back() {
        dismiss(animated: true, completion: nil)
    }

    private func configure() {
        drawDesign()
        makeTabBar()
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

extension MovieDetailViewController {

    func makeTabBar() {
        self.navigationItem.hidesBackButton = true
        let button = UIButton(type: .system)
        button.setImage(AwesomePro.Light.angleLeft.asImage(size: 35), for: .normal)
        button.setTitle("Back", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }

    func makeMoviewDetailView() {
        view.addSubview(movieDetailView)
        movieDetailView.snp.makeConstraints { (make) -> Void in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
