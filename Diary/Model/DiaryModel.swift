//
//  Model.swift
//  Diary
//
//  Created by 이해주 on 2022/04/15.
//

import Foundation

struct DiaryModel {
    
    var diaryList: [Diary] = [Diary(id: UUID(), title: "제목1", content: "관련 내용이 들어갑니다. 관련 내용이 들어갑니다. 관련 내용이 들어갑니다. 관련 내용이 들어갑니다.",  date: "날짜")]
    
    
    struct Diary: Identifiable {
        var id: UUID
        var title: String
        var content: String
        var date: String
    }
    
}
