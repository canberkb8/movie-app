//
//  PopularMoviesTableViewCell.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

import UIKit
import Awesome

class PopularMoviesTableViewCell: UITableViewCell {

    private let util = Utils()
    lazy var popularMovieCell: UIView = UIView()
    lazy var popularMovieImage: UIImageView = UIImageView()
    lazy var popularIconRigthArrow: UIImageView = UIImageView()
    lazy var popularMovieTitle: UILabel = UILabel()
    lazy var popularMovieRating: CircularProgressView = CircularProgressView(frame: CGRect(x: 2.0, y: 2.0, width: 50.0, height: 50.0))
    lazy var popularMovieReleaseDate: UILabel = UILabel()
    lazy var popularMovieOverview: UILabel = UILabel()

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
        popularMovieImage.layer.cornerRadius = 5
        popularMovieImage.af.setImage(withURL: URL(string: EndPoint.smallImagePath(url: url))!)
        popularMovieImage.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(120)
            make.height.equalTo(150)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
    }

    private func makeIconRigthArrow() {
        popularMovieCell.addSubview(popularIconRigthArrow)
        popularIconRigthArrow.sizeToFit()
        popularIconRigthArrow.image = Awesome.Solid.angleRight.asImage(size: CGSize(width: 25, height: 25), color: .black, backgroundColor: .white)
        popularIconRigthArrow.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(25)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview().offset(0)
        }
    }

    private func makeTitle(title: String?) {
        popularMovieCell.addSubview(popularMovieTitle)
        popularMovieTitle.text = title
        popularMovieTitle.textColor = .black
        popularMovieTitle.font = popularMovieTitle.font.withSize(18)
        popularMovieTitle.numberOfLines = 0
        popularMovieTitle.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(popularMovieImage.snp.right).offset(10)
            make.top.equalTo(popularMovieImage.snp.top).offset(0)
            make.right.equalToSuperview().offset(-10)
        }
    }

    private func makeRating(rating: Double) {
        popularMovieCell.addSubview(popularMovieRating)
        popularMovieRating.setProgressWithAnimation(duration: 0.5, value: (Float(rating) / 10))
        popularMovieRating.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.top.equalTo(popularMovieTitle.snp.bottom).offset(10)
            make.left.equalTo(popularMovieTitle.snp.left).offset(0)
        }
    }

    private func makeReleaseDate(date: String) {
        popularMovieCell.addSubview(popularMovieReleaseDate)
        popularMovieReleaseDate.text = util.getStringToDate(date: date)
        popularMovieReleaseDate.textAlignment = .left
        popularMovieReleaseDate.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(popularMovieRating)
            make.left.equalTo(popularMovieRating.snp.right).offset(10)
            make.right.equalToSuperview().offset(0)
        }
    }

    private func makeOverview(overview: String) {
        popularMovieCell.addSubview(popularMovieOverview)
        popularMovieOverview.text = overview
        popularMovieOverview.textColor = .lightGray
        popularMovieOverview.font = popularMovieOverview.font.withSize(14)
        popularMovieOverview.numberOfLines = 0
        popularMovieOverview.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(popularMovieTitle.snp.left).offset(0)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(popularMovieRating.snp.bottom).offset(10)
            make.bottom.equalTo(popularMovieImage.snp.bottom).offset(0)
        }
    }

    func saveModel(model: PopularMovieResults) {
        makeCell()
        makeImage(url: model.poster_path ?? "")
        //makeIconRigthArrow()
        makeTitle(title: model.title ?? "")
        makeRating(rating: model.vote_average ?? 0.0)
        makeReleaseDate(date: model.release_date ?? "")
        makeOverview(overview: model.overview ?? "")
    }

}
