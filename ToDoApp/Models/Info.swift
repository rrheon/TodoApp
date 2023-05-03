//
//  DataManager.swift
//  ToDoApp
//
//  Created by 최용헌 on 2023/04/12.
//
struct Info {
    let title: String
    let priority: String?
    let memo: String
    let date: String
    var isCompleted: Bool
    
    init(title: String, priority: String?, memo: String, date: String = "", isCompleted: Bool) {
        self.title = title
        self.priority = priority
        self.memo = memo
        self.date = date
        self.isCompleted = isCompleted
    }
}
