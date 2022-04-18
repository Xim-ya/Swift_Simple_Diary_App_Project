import UIKit

class TableViewController: UITabBarController, UITabBarControllerDelegate {
       
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
