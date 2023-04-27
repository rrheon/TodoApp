//
//  DataManager.swift
//  ToDoApp
//
//  Created by 최용헌 on 2023/04/12.
//

import UIKit

struct Info {
    let title: String
    let priority: String?
    let memo: String
    let date: String
    var isCompleted: Bool = false
    
    init(title: String, priority: String?, memo: String, date: String = "") {
        self.title = title
        self.priority = priority
        self.memo = memo
        self.date = date
    }
}
