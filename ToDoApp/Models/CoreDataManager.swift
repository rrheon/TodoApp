//
//  CoreDataManager.swift
//  ToDoApp
//
//  Created by 최용헌 on 2023/05/15.
//

import UIKit

import CoreData

//MARK: - To do 관리하는 매니저 (코어데이터 관리)
final class CoreDataManager {
  static let shared = CoreDataManager()
  private init() {}
  
  // 앱 델리게이트, 앱이 실행될 때 하나의 앱을 관리해주는 객체, 앱의 라이프사이관리를 담당
  let appDelegate = UIApplication.shared.delegate as? AppDelegate
  
  // CoreData에서 데이터 생성 병경 저장, 임시저장소
  lazy var context = appDelegate?.persistentContainer.viewContext
  
  // 엔터티 이름 (코어데이터에 저장된 객체)
  let modelName: String = "ToDoData"
  
  // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
  func getToDoList() throws -> [ToDoData] {
    var toDoList: [ToDoData] = []
    // 임시저장소 있는지 확인
    if let context = context {
      let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
      // 정렬순서를 정해서 넘겨줌
      let dateOrder = NSSortDescriptor(key: "date", ascending: true)
      request.sortDescriptors = [dateOrder]
      
      do {
        // 임시저장소에서 데이터 가져오기 (fetch메서드)
        if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
          toDoList = fetchedToDoList
        }
      } catch {
        print("가져오는 것 실패")
        throw(error)
      }
    }
    
    return toDoList
  }
  
  // MARK: - [Create] 코어데이터에 데이터 생성하기
  func saveToDoData(title: String?, memo: String?,
                    date: String, isCompleted: Bool,
                    priority: String ,completion: @escaping () -> Void) {
    // 임시저장소 있는지 확인
    if let context = context {
      // 임시저장소에 있는 데이터를 그려줄 형태 파악하기, 실체를 뽑아낸다.
      if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
        
        // 임시저장소에 올라가게 할 객체만들기 (NSManagedObject ===> ToDoData)
        if let toDoData = NSManagedObject(entity: entity, insertInto: context) as? ToDoData {
          toDoData.title = title
          toDoData.memo = memo
          toDoData.date = date
          toDoData.isCompleted = isCompleted
          toDoData.priority = priority
          
          if context.hasChanges {
            do {
              try context.save()  // 영구저장소(하드)에 저장
              completion()
            } catch {
              print(error)
              completion()
            }
          }
        }
      }
    }
    completion()
  }
  
  // MARK: - [Delete] 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 ===> 삭제)
  func deleteToDo(data: ToDoData, completion: @escaping () -> Void) {
    guard let context = self.context else { return }
    
    context.delete(data)
    do {
      try context.save()
      completion()
    } catch {
      print("Failed to delete to-do data: \(error.localizedDescription)")
      completion()
    }
  }
  
  // MARK: - [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 ===> 수정)
  func updateToDo(existingToDoData: ToDoData, title: String?,
                  memo: String?, date: String,
                  isCompleted: Bool, priority: String,
                  completion: @escaping () -> Void) {
    
    // 임시저장소 있는지 확인
    if let context = context {
      // 요청서
      let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
      // 단서 / 찾기 위한 조건 설정
      request.predicate = NSPredicate(format: "self = %@", existingToDoData)
      
      do {
        // 요청서를 통해서 데이터 가져오기
        if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
          // 배열의 첫번째
          if let targetToDo = fetchedToDoList.first {
            targetToDo.title = title
            targetToDo.memo = memo
            targetToDo.date = date
            targetToDo.isCompleted = isCompleted
            targetToDo.priority = priority
            
            if context.hasChanges {
              do {
                try context.save()
                completion()
              } catch {
                print(error)
                completion()
              }
            }
          }
        }
        completion()
      } catch {
        print("갱신 실패")
        completion()
      }
    }
  }
  // MARK: - [Update] 코어데이터에서 데이터 수정하기_확인여부만
  func updateToDoCompleted(existingToDoData: ToDoData,
                          isCompleted: Bool, completion: @escaping () -> Void) {
    // 임시저장소 있는지 확인
    if let context = context {
      // 요청서
      let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
      // 단서 / 찾기 위한 조건 설정
      request.predicate = NSPredicate(format: "self = %@", existingToDoData)
      
      do {
        // 요청서를 통해서 데이터 가져오기
        if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
          // 배열의 첫번째
          if let targetToDo = fetchedToDoList.first {
            targetToDo.isCompleted = isCompleted
            
            if context.hasChanges {
              do {
                try context.save()
                completion()
              } catch {
                print(error)
                completion()
              }
            }
          }
        }
        completion()
      } catch {
        print("갱신 실패")
        completion()
      }
    }
  }
}
