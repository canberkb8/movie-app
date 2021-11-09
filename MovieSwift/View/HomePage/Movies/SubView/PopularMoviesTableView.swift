//
//  PopularMoviesTableView.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//
import UIKit

protocol PopularMoviesTableViewProtocol {
    func update(newItemList: [MovieResults], newPage: Bool)
}

protocol PopularMoviesTableViewOutput: class {
    func onSelected(item: MovieResults)
    func reloadNextPage()
}

final class PopularMoviesTableView: NSObject {

    private lazy var itemList: [MovieResults] = []

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

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // need to pass your indexpath then it showing your indicator at bottom
        tableView.addLoading(indexPath) {
            self.delegate?.reloadNextPage()
            tableView.stopLoading()
        }
    }
}

extension PopularMoviesTableView: UITableViewDelegate, UITableViewDataSource { }
extension PopularMoviesTableView: PopularMoviesTableViewProtocol {
    func update(newItemList: [MovieResults], newPage: Bool) {
        if newPage{
            self.itemList.append(contentsOf: newItemList)
        }else{
            self.itemList = newItemList
        }
        
    }
}
