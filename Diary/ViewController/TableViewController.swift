//
//  TableViewController.swift
//  Diary
//
//  Created by 이해주 on 2022/04/15.
//

import UIKit

class TableViewController: UITabBarController, UITabBarControllerDelegate, ReloadVCDelegate {
   
    
    var diaryVM = DiaryVM() // VIEW MODEL

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Load VicewController Instance
        let diaryContainerVC = DiaryContainerViewController(vm: diaryVM)
        let favoriteVC = FavoriteViewController(vm: diaryVM)
        
        // Set ViewController Title
        diaryContainerVC.title = "일기함"
        favoriteVC.title = "즐겨찾기"
    
        // Set delegate
        favoriteVC.vcDelegate = self
        diaryContainerVC.vcDelegate = self
    
        
        // Set Tab Bar Item Image
        diaryContainerVC.tabBarItem.image = UIImage(systemName: "folder.fill")
        favoriteVC.tabBarItem.image = UIImage(systemName: "star")
        
        // Make Each ViewController to Root ViewController Instance
        let diaryContainerNV = UINavigationController(rootViewController: diaryContainerVC)
        let favoriteNV = UINavigationController(rootViewController: favoriteVC)
        
        
        self.tabBar.backgroundColor = .gray.withAlphaComponent(0.1)

        setViewControllers([diaryContainerNV, favoriteNV], animated: true)
        
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
 
    }

    func reloadVC(cv: UICollectionView) {
      
        cv.reloadData()
    }
    
    
    
 
}

protocol ReloadVCDelegate {
    func reloadVC(cv: UICollectionView)
}
