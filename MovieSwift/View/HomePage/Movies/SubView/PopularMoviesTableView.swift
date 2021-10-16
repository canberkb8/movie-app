//
//  PopularMoviesTableView.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//
import UIKit

protocol PopularMoviesTableViewProtocol {
    func update(newItemList: [PopularMovieResults])
}

protocol PopularMoviesTableViewOutput: class {
    func onSelected(item: PopularMovieResults)
}

final class PopularMoviesTableView: NSObject {

    private lazy var itemList: [PopularMovieResults] = []

    ///TableView Output Delegate
    weak var delegate: PopularMoviesTableViewOutput?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell: PopularMoviesTableViewCell = tableView.dequeueReusableCell(withIdentifier: PopularMoviesTableViewCell.Identifier.custom.rawValue) as? PopularMoviesTableViewCell else {
            return UITableViewCell()
        }
        cell.saveModel(model: itemList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onSelected(item: itemList[indexPath.row])
    }
}

extension PopularMoviesTableView: UITableViewDelegate, UITableViewDataSource { }
extension PopularMoviesTableView: PopularMoviesTableViewProtocol {
    func update(newItemList: [PopularMovieResults]) {
        self.itemList = newItemList
    }
}
