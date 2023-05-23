//
//  UITextFieldExtention.swift
//  ToDoApp
//
//  Created by 최용헌 on 2023/05/23.
//

import UIKit

// MARK: - padding 추가함수
extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
