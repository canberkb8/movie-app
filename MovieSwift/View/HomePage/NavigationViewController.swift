//
//  NavigationViewController.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

import UIKit
import Awesome

class NavigationViewController: UITabBarController {

    let moviesVC = MoviesViewController()
    let randomMovieVC = RandomMovieViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        moviesVC.tabBarItem.image = AwesomePro.Light.film.asImage(size: 40.0)
        moviesVC.title = "Movies"

        randomMovieVC.tabBarItem.image = AwesomePro.Light.popcorn.asImage(size: 40.0)
        randomMovieVC.title = "Suggestion"

        let controllers: [UIViewController] = [moviesVC, randomMovieVC]

        viewControllers = controllers
        self.selectedIndex = 0
    }

}
