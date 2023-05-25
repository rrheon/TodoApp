//
//  MainViewController.swift
//  ToDoApp
//
//  Created by 최용헌 on 2023/04/11.
//
import UIKit

protocol AddItemDelegate: AnyObject {
  func updateItemStatus()
}

final class MainViewController: UIViewController, AddItemDelegate {
  let toDoManager = CoreDataManager.shared
  var toDoData: [ToDoData] = []
  
  private let sections: [String] = ["해야할 것", "Completed"]
  
  // MARK: - tableView 설정
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.cellId)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 120
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "ToDoList"
    self.view.backgroundColor = .white
    
    view.addSubview(tableView)
    
    setNavigationbar()
    setTableVeiwLayout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // 코어 데이터에서 데이터 가져오기
    toDoData = toDoManager.getToDoList()
    tableView.reloadData()
  }

}

// MARK: - 메서드 설정
extension MainViewController {
 
  // MARK: - TableView Layout 설정
  func setTableVeiwLayout(){
    tableView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
  }
  
  // MARK: - navigationbar 설정
  func setNavigationbar(){
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: "Log out",
      style: .plain,
      target: self,
      action: #selector(goToLoginVC)
    )
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "plus"),
      style: .plain,
      target: self,
      action: #selector(addTableView)
    )
  }
  
  func updateItemStatus() {
    toDoData = toDoManager.getToDoList()
    tableView.reloadData()
  }
  
  @objc private func goToLoginVC() {
    let loginVC = LoginViewController()
    self.navigationController?.pushViewController(loginVC, animated: true)
  }
  
  @objc private func addTableView() {
    let addItemVC = AddItemViewController()
    self.navigationController?.pushViewController(addItemVC, animated: true)
    addItemVC.delegate = self
  }
}

// MARK: - tableView custom
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      // 해야할 것 섹션에는 isCompleted가 false인 데이터만 표시.
      return toDoManager.getToDoList().filter{ $0.isCompleted == false }.count
    } else if section == 1 {
      // Completed 섹션에는 isCompleted가 true인 데이터만 표시.
      return toDoManager.getToDoList().filter{ $0.isCompleted == true }.count
    }
    return 0
  }
  
  // MARK: -  cell에 데이터 전달
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.cellId,
                                             for: indexPath) as! CustomCell
    
    // 반환할 작업 목록 선택
    let item = toDoItemForIndexPath(indexPath)
    
    cell.toDoData = item
    cell.selectionStyle = .none
    
    return cell
  }
  
  // MARK: - 기존의 cell 수정
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let selectedItem: ToDoData = toDoItemForIndexPath(indexPath)
    let editItemViewController = AddItemViewController()
    
    editItemViewController.itemToEdit = selectedItem
    self.navigationController?.pushViewController(editItemViewController, animated: true)
    editItemViewController.delegate = self
  }
  
  // MARK: - 왼쪽으로 스와이프하여 기존의 cell 삭제
  func tableView(_ tableView: UITableView,
                 trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
  )-> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(style: .destructive,
                                          title: "삭제") { (action, view, completion) in
      
      let item = self.toDoItemForIndexPath(indexPath)
      self.toDoManager.deleteToDo(data: item) { [weak self] in
        
        DispatchQueue.main.async { // 메인 스레드에서 실행
          self?.updateItemStatus()
        }
        if let strongSelf = self {
          strongSelf.tableView.deleteRows(at: [indexPath], with: .fade)
          completion(true)
        }
      }
    }
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
    swipeConfiguration.performsFirstActionWithFullSwipe = false
    
    return swipeConfiguration
  }
  // MARK: - 오른쪽으로 스와이프하여 check 활성화
  func tableView(_ tableView: UITableView,
                 leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
  ) -> UISwipeActionsConfiguration? {
    
    let item = toDoItemForIndexPath(indexPath)
    let isCompleted = item.isCompleted ? false : true
    let completedStatus = UIContextualAction(style: .normal,
                                             title: isCompleted ?
                                             "completed" : "cancel") { action, view, success in
      self.toDoManager.updateToDoCompleted(existingToDoData: item,
                                           isCompleted: isCompleted) {
        self.updateItemStatus()
      }
    }
    completedStatus.backgroundColor = item.isCompleted ? .red : .green
    
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [completedStatus])
    swipeConfiguration.performsFirstActionWithFullSwipe = false
    
    return swipeConfiguration
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section]
  }
  
  func toDoItemForIndexPath(_ indexPath: IndexPath) -> ToDoData {
    let item: ToDoData
    if indexPath.section == 0 {
      item = self.toDoManager.getToDoList().filter{ $0.isCompleted == false }[indexPath.row]
    } else {
      item = self.toDoManager.getToDoList().filter{ $0.isCompleted == true }[indexPath.row]
    }
    return item
  }
}
