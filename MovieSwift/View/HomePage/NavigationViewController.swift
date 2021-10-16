//
//  NavigationViewController.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

import UIKit

class NavigationViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let MoviesVC = MoviesViewController()
        //MoviesVC.tabBarItem.image = UIImage.fontAwesomeIcon(.Briefcase)
        MoviesVC.title = "Movies"

        let controllers: [UIViewController] = [MoviesVC]

        viewControllers = controllers
        self.selectedIndex = 0
    }

}
