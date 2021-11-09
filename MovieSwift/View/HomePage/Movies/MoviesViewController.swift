//
//  MoviesViewController.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

import UIKit

protocol MoviesViewOutPut {
    func changeLoading(isLoad: Bool)
    func movieData(isSuccess: Bool, error: Int?, data: MovieResponseModel?)
}

final class MoviesViewController: UIViewController {

    private var moviesViewModel: IMoviesViewModel = MoviesViewModel()
    private let popularMoviesTableView: PopularMoviesTableView = PopularMoviesTableView()
    private var pageCounter = 1

    lazy var loadingDialog = LoadingDialog()
    lazy var tableView = UITableView()
    lazy var searchBar = UISearchBar()
    lazy var searchText = String()
    private var tabBar = UISegmentedControl(items: ["Popular", "Top Rated", "Upcoming", "Now Play"])

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        moviesViewModel.setDelegate(output: self)
        initTableViewDelegate()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        moviesViewModel.getMovie(endPoint: EndPoint.moviePopularPath(page: String(pageCounter)))
    }

    @objc private func tabBarClick() {
        pageCounter = 1
        searchText = ""
        switch tabBar.selectedSegmentIndex {
        case 0: moviesViewModel.getMovie(endPoint: EndPoint.moviePopularPath(page: String(pageCounter)))
        case 1: moviesViewModel.getMovie(endPoint: EndPoint.movieTopRatedPath(page: String(pageCounter)))
        case 2: moviesViewModel.getMovie(endPoint: EndPoint.movieUpComingPath(page: String(pageCounter)))
        case 3: moviesViewModel.getMovie(endPoint: EndPoint.movieNowPlayPath(page: String(pageCounter)))
        default: break
        }
        let topCell: NSIndexPath = NSIndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: topCell as IndexPath, at: UITableView.ScrollPosition.none, animated: true)
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
        makeSearchBar()
        makeTabBar()
        makePopularMoviesTableView()
    }

    private func drawDesign() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
        }
    }

}

extension MoviesViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        pageCounter = 1
        guard let text = searchBar.text else {
            return
        }
        searchText = text
        moviesViewModel.getMovie(endPoint: EndPoint.searchMoviePath(query: searchText, page: String(pageCounter)))
    }
}

extension MoviesViewController: MoviesViewOutPut {
    func movieData(isSuccess: Bool, error: Int? = nil, data: MovieResponseModel? = nil) {
        if isSuccess {
            if pageCounter == 1 {
                self.popularMoviesTableView.update(newItemList: (data?.results) ?? [], newPage: false)
            } else {
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
        if searchText == "" {
            switch tabBar.selectedSegmentIndex {
            case 0: moviesViewModel.getMovieNextPage(endPoint: EndPoint.moviePopularPath(page: String(pageCounter)))
            case 1: moviesViewModel.getMovieNextPage(endPoint: EndPoint.movieTopRatedPath(page: String(pageCounter)))
            case 2: moviesViewModel.getMovieNextPage(endPoint: EndPoint.movieUpComingPath(page: String(pageCounter)))
            case 3: moviesViewModel.getMovieNextPage(endPoint: EndPoint.movieNowPlayPath(page: String(pageCounter)))
            default: break
            }
        } else {
            moviesViewModel.getMovieNextPage(endPoint: EndPoint.searchMoviePath(query: searchText, page: String(pageCounter)))
        }
    }

    func onSelected(item: MovieResults) {
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.movieDetailID = item.id!
        let movieDetailNavigationController = UINavigationController(rootViewController: movieDetailVC)
        movieDetailNavigationController.modalPresentationStyle = .fullScreen
        present(movieDetailNavigationController, animated: true, completion: nil)
    }
}

extension MoviesViewController {
    func makeSearchBar() {
        view.addSubview(searchBar)
        searchBar.sizeToFit()
        searchBar.placeholder = "Search Movie"
        searchBar.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }

    func makeTabBar() {
        view.addSubview(tabBar)
        tabBar.addTarget(self, action: #selector(tabBarClick), for: .valueChanged)
        tabBar.selectedSegmentIndex = 0
        tabBar.selectedSegmentTintColor = .goldYellow
        tabBar.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(35)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-35)
            make.top.equalTo(searchBar.snp.bottom).offset(10)
        }
    }

    func makePopularMoviesTableView() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(tabBar.snp.bottom).offset(10)
        }
    }
}
