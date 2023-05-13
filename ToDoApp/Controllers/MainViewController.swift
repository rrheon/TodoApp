//
//  MainViewController.swift
//  ToDoApp
//
//  Created by 최용헌 on 2023/04/11.
//
import UIKit

final class MainViewController: UIViewController, AddItemDelegate {
  // TableView에 사용될 데이터 모델
  var items = [Info]()
  var itemToEdit: Info?

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
    exampleDataModles()
  }
  
  // MARK: - 데이터 모델 초기화
  func exampleDataModles(){
    items = [
      Info(id:1,title:"입력하는 내용의 길이에 따라서 main에서 cell의 크기가 같이 늘어나는지 test",
           priority: "High",
           memo: "item 1",
           date: "2023-04-28",
           isCompleted: false),
      Info(id:2,title:"2",
           priority: "Medium",
           memo: "item 2",
           date: "2023-04-29",
           isCompleted: true),
      Info(id:3,title:"3",
           priority: "Low",
           memo: "item 3", date: "2023-04-30", isCompleted: true)
    ]
  }
  // MARK: - TableView Layout 설정
  func setTableVeiwLayout(){
    tableView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide)}
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
}

// MARK: - 메서드 설정
extension MainViewController {
  @objc private func goToLoginVC() {
    let loginVC = LoginViewController()
    self.navigationController?.pushViewController(loginVC, animated: true)
  }
  
  @objc private func addTableView() {
    let addItemVC = AddItemViewController()
    self.navigationController?.pushViewController(addItemVC, animated: true)
    addItemVC.delegate = self
  }
  
  func addItem(item: Info) {
    items.append(item)
    sortItem(item: item)
    tableView.reloadData()
  }

  func editItem(item: Info) {
     if let index = items.firstIndex(where: { $0.id == item.id }) {
       items[index] = item
       sortItem(item: item)
       tableView.reloadData()
     }
   }
  
  func sortItem(item: Info) {
    items.sort {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd"
      if let date1 = formatter.date(from: $0.date), let date2 = formatter.date(from: $1.date) {
        return date1 < date2
      } else {
        return false
      }
    }
  }
}

// MARK: - tableView custom
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  // MARK: - cell에 데이터 전달
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.cellId,
                                             for: indexPath) as! CustomCell
    
    cell.titleLabel.text = items[indexPath.row].title
    cell.deadlineLabel.text = items[indexPath.row].date
    cell.priorityLabel.text = items[indexPath.row].priority
    
    configureCompletedImageView(cell, items[indexPath.row].isCompleted)
    if let priorityOption = PriorityOptions(rawValue: cell.priorityLabel.text ?? "") {
        configurePriorityLabel(cell, priorityOption)
    }
    cell.selectionStyle = .none
    cell.makeUI()
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let selectedItem = items[indexPath.row]
    let editItemViewController = AddItemViewController()
    editItemViewController.itemToEdit = selectedItem
    self.navigationController?.pushViewController(editItemViewController, animated: true)
    editItemViewController.delegate = self
    itemToEdit = selectedItem
  }
 
  func tableView(_ tableView: UITableView,
                 trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
                  -> UISwipeActionsConfiguration? {
      let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completion) in
          self.items.remove(at: indexPath.row)
          tableView.deleteRows(at: [indexPath], with: .fade)
          completion(true)
      }
      let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
      swipeConfiguration.performsFirstActionWithFullSwipe = false
      
      return swipeConfiguration
  }
  // MARK: - completed 확인함수
  func configureCompletedImageView(_ cell: CustomCell, _ isCompleted: Bool) {
    if isCompleted {
      cell.completedImageView.image = UIImage(systemName: "checkmark.circle")
      cell.completedImageView.tintColor = UIColor.systemGreen
    } else {
      cell.completedImageView.image = nil
    }
  }
  
  // MARK: - 우선순위확인함수, enum사용해서
  func configurePriorityLabel(_ cell: CustomCell, _ priority: PriorityOptions) {
      switch priority {
      case .low:
          cell.priorityLabel.backgroundColor = Color.low.uiColor
      case .medium:
          cell.priorityLabel.backgroundColor = Color.medium.uiColor
      case .high:
          cell.priorityLabel.backgroundColor = Color.high.uiColor
      }
  }
}

extension UITableView {
    var rowsCount: Int {
        let sections = self.numberOfSections
        var rows = 0

        for i in 0...sections - 1 {
            rows += self.numberOfRows(inSection: i)
        }

        return rows
    }
}
