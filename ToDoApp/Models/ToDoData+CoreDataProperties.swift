//
//  ToDoData+CoreDataProperties.swift
//  ToDoApp
//
//  Created by 최용헌 on 2023/05/15.
//
//

import Foundation
import CoreData


extension ToDoData {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoData> {
    return NSFetchRequest<ToDoData>(entityName: "ToDoData")
  }
  
  @NSManaged public var id: Int64
  @NSManaged public var priority: String?
  @NSManaged public var title: String?
  @NSManaged public var memo: String?
  @NSManaged public var isCompleted: Bool
  @NSManaged public var date: String?
  
}

extension ToDoData : Identifiable {
  
}
