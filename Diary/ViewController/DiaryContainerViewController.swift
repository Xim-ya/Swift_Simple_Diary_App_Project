
import UIKit

class DiaryContainerViewController: UIViewController, UpdateViewDelegate {

    var diaryVM: DiaryVM // VIEW MODEL
    var vcDelegate: ReloadVCDelegate?
    
    
    // Fetch View Model
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
        
        /* Set Components Config */
        setCollectionView()
        
        
    }
    
    // MARK: Set Components Configuartions
    
    func setCollectionView(){
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }
    
    
    // MARK: Intent
    
    ///  Route To AddDiarVC
    @objc func routeToAddDiaryVC() {
        let vc = AddEditDiaryViewController(vm: diaryVM, isRoutedForDiaryDetail: false, selectedIndex: nil)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// Delegate Method (when Diary is Added0
    func reloadCollectionView() {
        collectionView.reloadData()
        vcDelegate?.reloadVC(cv: collectionView)
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

extension DiaryContainerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    /// sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width - 42) / 2
        return CGSize(width: size, height: size)
    }
        

    /// numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diaryVM.diaryList().count
    }

    /// cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryCollectionViewCell.cellID, for: indexPath) as! DiaryCollectionViewCell
        cell.titleLabel.text = diaryVM.diaryList()[indexPath.item].title
        cell.contentLabel.text = diaryVM.diaryList()[indexPath.item].content
        cell.dateLabel.text = diaryVM.diaryList()[indexPath.item].date
        return cell
    }
    
    
    /// didSeleItemAt 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AddEditDiaryViewController(vm: diaryVM, isRoutedForDiaryDetail: true, selectedIndex: indexPath.item)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

protocol UpdateViewDelegate {
    func reloadCollectionView()
}

