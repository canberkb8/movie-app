//
//  SplashViewController.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 13.11.2021.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    private let animLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 3) {
            self.animLabel.alpha = 1
        } completion: { (done) in
            if(done) {
                UIView.animate(withDuration: 3) {
                    self.animLabel.alpha = 0
                } completion: { (done) in
                    if(done) {
                        let homePage = NavigationViewController(nibName: nil, bundle: nil)
                        UIApplication.shared.windows.first!.rootViewController = homePage
                    }
                }
            }
        }
    }

    private func configure() {
        drawDesign()
        makeAnimLabel()
    }

    private func drawDesign() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
        }
    }

}

extension SplashViewController {
    func makeAnimLabel() {
        view.addSubview(animLabel)
        animLabel.text = "Movie App"
        animLabel.textAlignment = .center
        animLabel.font = animLabel.font.withSize(30)
        animLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
        }
    }
}
