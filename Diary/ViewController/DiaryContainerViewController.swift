
import UIKit

class DiaryContainerViewController: UIViewController, UpdateViewDelegate {

    var diaryVM: DiaryVM // VIEW MODEL
 
    init(vm: DiaryVM?) {
        self.diaryVM = vm!
        super.init(nibName: nil, bundle: nil)
    }
    

    lazy var addBarButton: UIBarButtonItem = {
        let barBtn = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.done, target: self, action: #selector(routeToAddDiaryVC))
        
        return barBtn
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = ReusebleAttribute.collectionViewAttr()
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        self.navigationItem.rightBarButtonItem = addBarButton
        
        setLayout()
    }
    
    // MARK: Set Layout
    func setLayout(){
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }
    
    
    // MARK: Intent
    ///  Route To AddDiarVC
    @objc func routeToAddDiaryVC() {
        let vc = AddEditDiaryViewController(vm: diaryVM, isRoutedForDiaryDetail: false, selectedId: UUID())
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// Delegate Method (when Diary is Added0
    func reloadCollectionView() {
        collectionView.reloadData()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


protocol UpdateViewDelegate {
    func reloadCollectionView()
}




