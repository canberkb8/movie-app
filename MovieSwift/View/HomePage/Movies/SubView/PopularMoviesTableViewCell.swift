//
//  PopularMoviesTableViewCell.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

import UIKit

class PopularMoviesTableViewCell: UITableViewCell {

    lazy var popularMovieCell: UIView = UIView()
    lazy var popularMovieImage: UIImageView = UIImageView()
    lazy var popularMovieTitle: UILabel = UILabel()

    enum Identifier: String {
        case custom = "popularMoviesTableViewCell"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .lightGray
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeCell() {
        addSubview(popularMovieCell)
        popularMovieCell.backgroundColor = .white
        popularMovieCell.layer.cornerRadius = 0
        popularMovieCell.snp.makeConstraints { (make) -> Void in
            make.top.left.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-1)
        }
    }

    private func makeImage(url: String) {
        popularMovieCell.addSubview(popularMovieImage)
        popularMovieImage.layer.masksToBounds = true
        popularMovieImage.layer.cornerRadius = 60
        popularMovieImage.af.setImage(withURL: URL(string: EndPoint.smallImagePath(url: url))!)
        popularMovieImage.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(120)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
    }

    private func makeTitle(title: String?) {
        popularMovieCell.addSubview(popularMovieTitle)
        popularMovieTitle.text = title
        popularMovieTitle.numberOfLines = 0
        popularMovieTitle.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(popularMovieImage.snp.right).offset(10)
            make.top.equalTo(popularMovieImage.snp.top).offset(0)
            make.right.equalToSuperview().offset(-10)
        }
    }

    func saveModel(model: PopularMovieResults) {
        makeCell()
        makeImage(url: model.poster_path ?? "")
        makeTitle(title: model.title ?? "")
    }

}
