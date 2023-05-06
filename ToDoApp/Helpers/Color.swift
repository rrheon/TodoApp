//
//  Color.swift
//  ToDoApp
//
//  Created by 최용헌 on 2023/05/01.
//

import UIKit

enum Color {
  case loginButtonBackground
  case registerButtonBackground
  case loginScreenBackground
  case loginButtonActiveBackground
  
  case low
  case medium
  case high
  
  case priority
  
  var uiColor: UIColor {
    switch self {
    case .loginButtonBackground:
      return UIColor(red: 0.20, green: 0.16, blue: 0.04, alpha: 1.00)
    case .registerButtonBackground:
      return UIColor(red: 0.81, green: 0.80, blue: 0.76, alpha: 1.00)
    case .loginScreenBackground:
      return UIColor(red: 0.87, green: 0.86, blue: 0.82, alpha: 1.00)
    case .loginButtonActiveBackground:
      return UIColor(red: 0.64, green: 0.53, blue: 0.32, alpha: 1.00)
    case .low:
      return UIColor(red: 0.65, green: 0.94, blue: 0.68, alpha: 1.00)
    case .medium:
      return UIColor(red: 0.92, green: 0.78, blue: 0.51, alpha: 1.00)
    case .high:
      return UIColor(red: 0.94, green: 0.01, blue: 0.24, alpha: 1.00)
    case .priority:
      return UIColor(red: 0.53, green: 0.85, blue: 0.84, alpha: 1.00)
    }
  }
}

