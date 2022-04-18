import UIKit


/// DiaryContainerViewConroller
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
 
        let vc = AddEditDiaryViewController(vm: diaryVM, isRoutedForDiaryDetail: true, selectedId: diaryVM.diaryList()[indexPath.item].id)
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


/// FavoriteViewController
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
        let vc = AddEditDiaryViewController(vm: diaryVM, isRoutedForDiaryDetail: true, selectedId: diaryVM.favoriteDiaryList()[indexPath.item].id)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

