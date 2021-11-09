//
//  MovieDetailView.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 22.10.2021.
//

import UIKit
import SnapKit
import AlamofireImage
import Awesome

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

    func makeGenres() {
        bannerImageView.addSubview(genres)
        genres.isHidden = false
        genres.spacing = 5
        genres.distribution = .fillProportionally
        genres.alignment = .center
        genres.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(subTitle.snp.left).offset(0)
            make.top.equalTo(subTitle.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-10)
        }
        for genre in movieDetailResponseModel?.genres ?? [] {
            let genreView = UIView()
            genreView.layer.cornerRadius = 15
            genreView.layer.masksToBounds = true
            genreView.backgroundColor = .black
            genreView.snp.makeConstraints { (make) in
                make.height.equalTo(30)
            }

            let genreLabel = PaddingLabel(withInsets: 16, 16, 16, 16)
            genreView.addSubview(genreLabel)
            genreLabel.text = genre.name
            genreLabel.textColor = .white
            genreLabel.font = genreLabel.font.withSize(14)
            genreLabel.snp.makeConstraints { (make) in
                make.left.centerY.equalToSuperview()
            }

            let genreIcon = UIImageView()
            genreView.addSubview(genreIcon)
            genreIcon.image = AwesomePro.Light.angleRight.asImage(size: 30, color: .white)
            genreIcon.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(genreLabel.snp.right)
            }
            genres.addArrangedSubview(genreView)
        }
    }
}
