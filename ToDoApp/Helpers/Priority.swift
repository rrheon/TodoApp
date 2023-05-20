//
//  Prioiry.swift
//  ToDoApp
//
//  Created by 최용헌 on 2023/05/01.
//

import UIKit

enum PriorityOptions: String, CaseIterable {
  case low = "Low"
  case medium = "Medium"
  case high = "High"
  
  var uicolor: UIColor {
    switch self {
    case .low:
      return UIColor(red: 0.65, green: 0.94, blue: 0.68, alpha: 1.00)
    case .medium:
      return UIColor(red: 0.92, green: 0.78, blue: 0.51, alpha: 1.00)
    case .high:
      return UIColor(red: 0.94, green: 0.01, blue: 0.24, alpha: 1.00)
    }
  }
}
