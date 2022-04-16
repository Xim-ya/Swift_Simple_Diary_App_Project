//
//  TableViewController.swift
//  Diary
//
//  Created by 이해주 on 2022/04/15.
//

import UIKit

class TableViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load VicewController Instance
        let diaryContainerVC = AddDairyViewController()
        let favoriteVC = FavoriteViewController()
        
        // Set ViewController Title
        diaryContainerVC.title = "일기함"
        favoriteVC.title = "즐겨찾기"
        
        // Set ViewController Background
        
        // Set Tab Bar Item Image
        diaryContainerVC.tabBarItem.image = UIImage(systemName: "folder.fill")
        favoriteVC.tabBarItem.image = UIImage(systemName: "star")
        
        // Make Each ViewController to Root ViewController Instance
        let diaryContainerNV = UINavigationController(rootViewController: diaryContainerVC)
        let favoriteNV = UINavigationController(rootViewController: favoriteVC)
        
        
        self.tabBar.backgroundColor = .gray.withAlphaComponent(0.1)


        setViewControllers([diaryContainerNV, favoriteNV], animated: true)
    }
}
