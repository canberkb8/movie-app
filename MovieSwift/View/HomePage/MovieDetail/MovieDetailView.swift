//
//  MovieDetailView.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 22.10.2021.
//

import UIKit
import SnapKit
import AlamofireImage

class MovieDetailView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    lazy var movieDetailResponseModel: MovieDetailResponseModel? = nil
    lazy var bannerImageView: UIImageView = UIImageView()
    lazy var title: UILabel = UILabel()
    lazy var subTitle: UILabel = UILabel()
    lazy var budget: UILabel = UILabel()
    lazy var genres: UIStackView = UIStackView()

    func setupView(model: MovieDetailResponseModel) {
        movieDetailResponseModel = model
        makeBanner()
        makeTitle()
        makeSubTitle()
        makeBudget()
        makeGenres()
    }
}

extension MovieDetailView {
    func makeBanner() {
        self.addSubview(bannerImageView)
        bannerImageView.af.setImage(withURL: URL(string: EndPoint.originalImagePath(url: movieDetailResponseModel?.backdrop_path ?? ""))!)
        bannerImageView.addBlur()
        bannerImageView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(Utils().screenHeight / 2)
            make.top.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }

    func makeTitle() {
        bannerImageView.addSubview(title)
        title.textColor = .goldYellow
        title.numberOfLines = 0
        title.font = title.font.withSize(24)
        title.text = movieDetailResponseModel?.title ?? "Title"
        title.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
    }

    func makeSubTitle() {
        bannerImageView.addSubview(subTitle)
        let releaseYear = Utils().getStringToYear(date: movieDetailResponseModel?.release_date ?? "") ?? ""
        let runTime = String(movieDetailResponseModel?.runtime ?? 0) + " minutes"
        let status = movieDetailResponseModel?.status ?? ""
        subTitle.text = releaseYear + " • " + runTime + " • " + status
        subTitle.textColor = .white
        subTitle.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(title.snp.left).offset(0)
            make.top.equalTo(title.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-10)
        }
    }

    func makeBudget() {
        bannerImageView.addSubview(budget)
        let budgetText = "Budget : " + String(movieDetailResponseModel?.budget ?? 0) + "$"
        let revenue = "Revenue : " + String(movieDetailResponseModel?.revenue ?? 0) + "$"
        budget.text = budgetText + " • " + revenue
        budget.textColor = .white
        budget.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(subTitle.snp.left).offset(0)
            make.top.equalTo(subTitle.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-10)
        }
    }
    func makeGenres() {
        bannerImageView.addSubview(genres)
        genres.isHidden = false
        genres.spacing = 10
        genres.distribution = .fillProportionally
        genres.alignment = .center
        genres.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(budget.snp.left).offset(0)
            make.top.equalTo(budget.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-10)
        }
        for genre in movieDetailResponseModel?.genres ?? [] {
            let label = UILabel()
            label.text = genre.name
            label.textColor = .white
            label.backgroundColor = .gray
            genres.addArrangedSubview(label)
        }
    }
}
