//
//  RandomMovieViewController.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 6.11.2021.
//

import UIKit

class RandomMovieViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        drawDesign()
    }

    private func drawDesign() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
        }
    }

}
