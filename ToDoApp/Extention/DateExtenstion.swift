//
//  DateExtenstion.swift
//  ToDoApp
//
//  Created by 최용헌 on 2023/05/23.
//

import Foundation

// MARK: - 날짜 to String 변경
extension Date {
  func toString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let deadLine = dateFormatter.string(from: self)
    return deadLine
  }
}
