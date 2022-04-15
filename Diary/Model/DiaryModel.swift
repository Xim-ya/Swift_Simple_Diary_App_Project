//
//  Model.swift
//  Diary
//
//  Created by 이해주 on 2022/04/15.
//

import Foundation

struct DiaryModel {
    
    var diaryList: [Diary] = [Diary(title: "임시 제목1", date: "임시 날짜"), Diary(title: "임시 제목1", date: "임시 날짜1"), Diary(title: "임시 제목1", date: "임시 날짜2")] 
    
    
    struct Diary {
        var title: String
        var date: String
    }
    
}
