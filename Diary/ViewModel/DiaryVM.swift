//
//  DiaryVM.swift
//  Diary
//
//  Created by 이해주 on 2022/04/15.
//

import Foundation


class DiaryVM {
    public var model = DiaryModel()
    typealias Diary = DiaryModel.Diary
    
    
    func diaryList() -> [Diary] {
        return model.diaryList
    }
    
}
