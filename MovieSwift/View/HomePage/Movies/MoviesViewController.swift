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

final class MoviesViewController: UIViewController {

    private var moviesViewModel: IMoviesViewModel = MoviesViewModel()
    private let popularMoviesTableView: PopularMoviesTableView = PopularMoviesTableView()
    private var pageCounter = 1

    lazy var loadingDialog = LoadingDialog()
    lazy var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        moviesViewModel.setDelegate(output: self)
        initTableViewDelegate()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        moviesViewModel.getPopularMovies(page: pageCounter)
    }

    private func initTableViewDelegate() {
        tableView.delegate = popularMoviesTableView
        tableView.dataSource = popularMoviesTableView
        popularMoviesTableView.delegate = self
        tableView.register(PopularMoviesTableViewCell.self, forCellReuseIdentifier: PopularMoviesTableViewCell.Identifier.custom.rawValue)
        tableView.rowHeight = 180
    }

    private func configure() {
        drawDesign()
        makePopularMoviesTableView()
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
            if pageCounter == 1 {
                self.popularMoviesTableView.update(newItemList: (data?.results) ?? [], newPage: false)
            }else{
                self.popularMoviesTableView.update(newItemList: (data?.results) ?? [], newPage: true)
            }
            self.tableView.reloadData()
        } else {
            print(error!)
        }
    }

    func changeLoading(isLoad: Bool) {
        if isLoad {
            loadingDialog.playAnimation()
            view.addSubview(loadingDialog)
        } else {
            loadingDialog.stopAnimation()
            loadingDialog.removeFromSuperview()
        }
    }
}

extension MoviesViewController: PopularMoviesTableViewOutput {
    func reloadNextPage() {
        pageCounter += 1
        moviesViewModel.getPopularMoviesNextPage(page: pageCounter)
    }
    
    func onSelected(item: PopularMovieResults) {
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.movieDetailID = item.id!
        let movieDetailNavigationController = UINavigationController(rootViewController: movieDetailVC)
        movieDetailNavigationController.modalPresentationStyle = .fullScreen
        present(movieDetailNavigationController, animated: true, completion: nil)
    }
}

extension MoviesViewController {
    func makePopularMoviesTableView() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
