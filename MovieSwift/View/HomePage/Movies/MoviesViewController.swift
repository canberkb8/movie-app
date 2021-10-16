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

    lazy var loadingDialog = LoadingDialog()
    lazy var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        moviesViewModel.setDelegate(output: self)
        moviesViewModel.getPopularMovies()

        initTableViewDelegate()
        configure()
    }

    private func initTableViewDelegate() {
        tableView.delegate = popularMoviesTableView
        tableView.dataSource = popularMoviesTableView
        popularMoviesTableView.delegate = self
        tableView.register(PopularMoviesTableViewCell.self, forCellReuseIdentifier: PopularMoviesTableViewCell.Identifier.custom.rawValue)
        tableView.rowHeight = 150
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
            self.popularMoviesTableView.update(newItemList: (data?.results) ?? [])
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
    func onSelected(item: PopularMovieResults) {
        print(item.title ?? "")
    }
}

extension MoviesViewController {
    func makePopularMoviesTableView() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(0)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(0)
        }
    }
}
