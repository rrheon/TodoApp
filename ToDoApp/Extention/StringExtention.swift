//
//  StringExtention.swift
//  ToDoApp
//
//  Created by 최용헌 on 2023/05/29.
//

import Foundation

// MARK: - 문자열 비었는지 확인
extension String {
  var nonEmpty: String? {
    if self.isEmpty { return nil }
    return self
  }
}
