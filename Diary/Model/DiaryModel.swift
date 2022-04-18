import Foundation

struct DiaryModel {
    
    var diaryList: [Diary] = [Diary(id: UUID(), title: "제목1", content: "관련 내용이 들어갑니다. 관련 내용이 들어갑니다. 관련 내용이 들어갑니다. 관련 내용이 들어갑니다.",  date: "2022년 4월 17일", isFavorite: true), Diary(id: UUID(), title: "제목2", content: "관련 내용이 들어갑니다2. 관련 내용이 들어갑니다2",  date: "2022년 4월 18일", isFavorite: false)]
    
    // MARK: INTENT
    /// 일기 추가
    mutating func addDiary(diary: Diary) {
        diaryList.append(diary)
    }

    /// 일기 즐겨찾기 토글 로직
    mutating func toggleFavorite(_ selectedId: UUID) {
        guard var selectedDiary = diaryList.first(where: {$0.id == selectedId}) else { return }
        selectedDiary.isFavorite.toggle()
        guard let index = diaryList.firstIndex(where: { diary in
            diary.id == selectedId
        }) else { return }
        diaryList[index] = selectedDiary
    }
    
    /// 일기 수정
    mutating func editDiary(_ selectedId: UUID, _ diary: Diary) {
        guard let index = diaryList.firstIndex(where: { diary in
            diary.id == selectedId
        }) else { return }
        diaryList[index] = diary
    }
    
    /// 일기 삭제
    mutating func deleteDiary(_ selectedId: UUID) {
        guard let index = diaryList.firstIndex(where: { diary in
            diary.id == selectedId
        }) else { return }
        diaryList.remove(at: index)
    }

    
    // MARK: MDOEL 
    struct Diary: Identifiable {
        let id: UUID
        var title: String
        var content: String
        var date: String
        var isFavorite = false
        
    }
    
}
