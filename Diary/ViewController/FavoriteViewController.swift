//
//  FavoriteViewController.swift
//  Diary
//
//  Created by 이해주 on 2022/04/15.
//

import UIKit

class FavoriteViewController: UIViewController, UpdateViewDelegate {
   
    var diaryVM: DiaryVM
    var vcDelegate: ReloadVCDelegate?
    
    
    
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
    
    func reloadCollectionView() {
        collectionView.reloadData()
        vcDelegate?.reloadVC(cv: collectionView)
        print("UPDATED!!!!")
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        setCollectionView()
    }
    
    // MARK: Set Components Configuartions
    
    func setCollectionView(){
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    /// sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width - 42) / 2
        return CGSize(width: size, height: size)
    }
        

    /// numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diaryVM.favoriteDiaryList().count
    }

    /// cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryCollectionViewCell.cellID, for: indexPath) as! DiaryCollectionViewCell
        cell.titleLabel.text = diaryVM.favoriteDiaryList()[indexPath.item].title
        cell.contentLabel.text = diaryVM.favoriteDiaryList()[indexPath.item].content
        cell.dateLabel.text = diaryVM.favoriteDiaryList()[indexPath.item].date
        return cell
    }
    
    
    /// didSeleItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AddEditDiaryViewController(vm: diaryVM, isRoutedForDiaryDetail: true, selectedIndex: indexPath.item)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

