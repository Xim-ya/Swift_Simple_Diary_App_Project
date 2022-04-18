//
//  Model.swift
//  Diary
//
//  Created by 이해주 on 2022/04/15.
//

import Foundation

struct DiaryModel {
    
    var diaryList: [Diary] = [Diary(id: UUID(), title: "제목1", content: "관련 내용이 들어갑니다. 관련 내용이 들어갑니다. 관련 내용이 들어갑니다. 관련 내용이 들어갑니다.",  date: "2023년 4월 17일", isFavorite: true), Diary(id: UUID(), title: "제목2", content: "관련 내용이 들어갑니다. 관련 내용이 들어갑니다. 관련 내용이 들어갑니다. 관련 내용이 들어갑니다.",  date: "2023년 4월 17일", isFavorite: false)]
    
    // MARK: INTENT
    /// 일기 추가
    mutating func addDiary(diary: Diary) {
        diaryList.append(diary)
    }

    /// 일기 즐겨찾기 토글 로직
    mutating func toggleFavorite(_ indexPath: Int) {
        var selectedDiary = diaryList[indexPath]
        selectedDiary.isFavorite = !selectedDiary.isFavorite
        diaryList[indexPath] = selectedDiary
    }
    
    /// 일기 수정
    mutating func editDiary(_ indexPath: Int, _ diary: Diary) {
        diaryList[indexPath] = diary
    }
    
    /// 일기 삭제
    mutating func deleteDiary(_ indexPath: Int) {
        diaryList.remove(at: indexPath)
    }
        
    struct Diary: Identifiable {
        let id: UUID
        var title: String
        var content: String
        var date: String
        var isFavorite = false
        
    }
    
}
