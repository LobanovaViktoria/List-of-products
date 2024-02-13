//
//  TabBarController.swift
//  NTI
//
//  Created by Viktoria Lobanova on 10.02.2024.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    class func configure() -> UIViewController {
        let listVC = UINavigationController(
            rootViewController: ListViewController(
                viewModel: ListViewModel()))
        listVC.tabBarItem.image = UIImage(systemName: "list.bullet")
        listVC.navigationBar.isHidden = true
        
        let cartVC = UINavigationController(
            rootViewController: CartViewController())
        cartVC.tabBarItem.image = UIImage(systemName: "bag")
        
        let infoVC = UINavigationController(
            rootViewController: InfoViewController())
        infoVC.tabBarItem.image = UIImage(systemName: "info")
        
        let tabBarController = TabBarController()
        tabBarController.viewControllers = [listVC, cartVC, infoVC]
        tabBarController.tabBar.backgroundColor = .background.blackNTI
        tabBarController.tabBar.tintColor = .fontColor.yellowNTI
        tabBarController.tabBar.unselectedItemTintColor = .fontColor.whiteNTI
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.clipsToBounds = true
        return tabBarController
    }
}
