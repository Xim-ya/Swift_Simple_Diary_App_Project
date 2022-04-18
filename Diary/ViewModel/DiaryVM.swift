
import UIKit


class DiaryVM: ObservableObject {
    @Published public var model = DiaryModel()
    typealias Diary = DiaryModel.Diary
    
    // MARK: Instance
    /// 전체 다이어리 리스트
    func diaryList() -> [Diary] {
        return model.diaryList
    }
        
    /// 즐겨찾기 추가된 일기 리스트
    func favoriteDiaryList() -> [Diary] {
        return model.diaryList.filter { $0.isFavorite == true }
    }
    
    /// 선택된 일기 (상세 스크린)
    func selectedDiary(_ selectedId: UUID) -> Diary? {
        guard let selectedDiary = diaryList().first(where: {$0.id == selectedId}) else { return nil }
        return selectedDiary
    }
    
    // MARK: INTENT

    /// 즐겨찾기 토글 로직
    func toggleFavorite(_ selectedId: UUID, _ barBtn: UIBarButtonItem) {
        guard let selectedDiary = diaryList().first(where: {$0.id == selectedId}) else { return }
        if selectedDiary.isFavorite {
            barBtn.image = UIImage(systemName: "star")
        } else {
            barBtn.image = UIImage(systemName: "star.fill")
        }
        return model.toggleFavorite(selectedId)
    }
    
    /// 일기 수정
    func editDiary(_ selectedIndex: UUID, _ diary: Diary) {
        model.editDiary(selectedIndex, diary)
    }
    
    /// 일기 추가
    func addDiary(diary: Diary) {
        model.addDiary(diary: diary)
    }
    
    // 일기 삭제
    func deleteDiary(_ selectedId: UUID) {
        model.deleteDiary(selectedId)
    }
    
}
