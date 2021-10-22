//
//  NavigationViewController.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

import UIKit
import Awesome

class NavigationViewController: UITabBarController {
    
    let MoviesVC = MoviesViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MoviesVC.tabBarItem.image = Awesome.Solid.film.asImage(size: 40.0)
        MoviesVC.title = "Movies"

        let controllers: [UIViewController] = [MoviesVC]

        viewControllers = controllers
        self.selectedIndex = 0
    }

}
