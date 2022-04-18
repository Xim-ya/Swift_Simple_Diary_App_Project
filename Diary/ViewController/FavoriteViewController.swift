import UIKit

class FavoriteViewController: UIViewController, UpdateViewDelegate {
   
    var diaryVM: DiaryVM
   
    init(vm: DiaryVM?) {
        self.diaryVM = vm!
        super.init(nibName: nil, bundle: nil)
    }
    
    
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
        setLayout()
    }
    
    // MARK: Set Components Configuartions
    
    func setLayout(){
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }
    
    // MARK: INTENT
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


