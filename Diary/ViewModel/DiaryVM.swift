
import UIKit


class DiaryVM: ObservableObject {
    @Published public var model = DiaryModel()
    typealias Diary = DiaryModel.Diary
    
    func diaryList() -> [Diary] {
        return model.diaryList
    }
    
    func selectedDiary(_ indexPath: Int) -> Diary {
        return model.diaryList[indexPath]
    }
    
    func toggleFavorite(_ indexPath: Int, _ barBtn: UIBarButtonItem) {
        let isFavorite = diaryList()[indexPath].isFavorite
        if isFavorite {
            barBtn.image = UIImage(systemName: "star")
        } else {
            barBtn.image = UIImage(systemName: "star.fill")
        }
        return model.toggleFavorite(indexPath)
    }
    
    func addDiary(diary: Diary) {
        model.addDiary(diary: diary)
    }
    
}
