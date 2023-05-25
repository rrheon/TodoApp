//
//  UITextViewExtention.swift
//  ToDoApp
//
//  Created by 최용헌 on 2023/05/23.
//

import UIKit

// MARK: - 문자 길이에 따라 크기 증가
extension UITextView {
  func adjustUITextViewHeight() {
    self.translatesAutoresizingMaskIntoConstraints = true
    self.sizeToFit()
    self.isScrollEnabled = false
  }
  
  // MARK: - 문자열 비었는지 확인
  func nonEmpty(_ str: String) -> String? {
    if str.isEmpty { return nil }
    return str
  }
}
