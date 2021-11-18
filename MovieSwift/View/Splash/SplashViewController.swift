//
//  SplashViewController.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 13.11.2021.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    private let darkTextLabel = UILabel()
    private let shinyTextLabel = UILabel()
    private let appName = "Movie App"

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        DispatchQueue.background(delay: 1.75, completion: {
            let homePage = NavigationViewController(nibName: nil, bundle: nil)
            UIApplication.shared.windows.first!.rootViewController = homePage
        })
    }

    private func configure() {
        drawDesign()
        makeAnimLabel()
    }

    private func drawDesign() {
        DispatchQueue.main.async {
            self.view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        }
    }

}

extension SplashViewController {

    func makeAnimLabel() {
        darkTextLabel.text = appName
        darkTextLabel.textColor = UIColor(white: 1, alpha: 0.2)
        darkTextLabel.font = UIFont.systemFont(ofSize: 80)
        darkTextLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        darkTextLabel.textAlignment = .center

        shinyTextLabel.text = appName
        shinyTextLabel.textColor = .white
        shinyTextLabel.font = UIFont.systemFont(ofSize: 80)
        shinyTextLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        shinyTextLabel.textAlignment = .center

        view.addSubview(shinyTextLabel)

        // pretty easy if you know the code to draw a gradient
        let gradientLayer = CAGradientLayer()
        // if you are following along, make sure to use cgColor
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = shinyTextLabel.frame

        let angle = 45 * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)

        shinyTextLabel.layer.mask = gradientLayer

        //animation
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 2
        animation.fromValue = -view.frame.width
        animation.toValue = view.frame.width
        animation.repeatCount = Float.infinity

        gradientLayer.add(animation, forKey: "doesn'tmatterJustSomeKey")
    }
}
