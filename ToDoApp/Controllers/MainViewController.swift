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
    
    // MARK: - tableView 설정
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 120
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.cellId)

        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ToDoList"
        self.view.backgroundColor = .white
    
        // TableView 설정
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        
        setNavigationbar()
        setTableVeiwLayout()
        exampleDataModles()
    }
    
    // MARK: - 데이터 모델 초기화
    func exampleDataModles(){
        items = [
            Info(title:"1",priority: "High", memo: "item 1", date: "2023-04-28", isCompleted: false),
            Info(title:"2",priority: "Medium", memo: "item 2", date: "2023-04-29", isCompleted: true),
            Info(title:"3",priority: "Low", memo: "item 3", date: "2023-04-30", isCompleted: true)
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
    @objc fileprivate func goToLoginVC() {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc fileprivate func addTableView() {
        let addItemVC = AddItemViewController()
        self.navigationController?.pushViewController(addItemVC, animated: true)
        addItemVC.delegate = self
    }

    func addItem(item: Info) {
        items.append(item)
        tableView.reloadData()
    }
}

// MARK: - tableView custom
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // MARK: - cell에 데이터 전달
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.cellId, for: indexPath) as! CustomCell
        
        cell.titleLabel.text = items[indexPath.row].title
        cell.deadlineLabel.text = items[indexPath.row].date
        cell.priorityLabel.text = items[indexPath.row].priority
        
        configureCompletedImageView(cell, items[indexPath.row].isCompleted)
        configurePriorityLabel(cell, cell.priorityLabel.text!)
        
        return cell
    }

    // MARK: - completed 확인함수
    func configureCompletedImageView(_ cell: CustomCell, _ isCompleted: Bool) {
        if isCompleted {
            cell.completedImageView.image = UIImage(systemName: "checkmark.circle")
            cell.completedImageView.tintColor = UIColor.systemGreen
        } else {
            cell.completedImageView.image = UIImage(systemName: "checkmark.circle")
            cell.completedImageView.tintColor = UIColor.red
        }
    }
    
    // MARK: - 우선순위확인함수
    func configurePriorityLabel(_ cell: CustomCell, _ priority: String) {
        switch priority {
        case "Low":
            cell.priorityLabel.backgroundColor = .green.withAlphaComponent(0.5)
        case "Medium":
            cell.priorityLabel.backgroundColor = .blue.withAlphaComponent(0.5)
        case "High":
            cell.priorityLabel.backgroundColor = .red.withAlphaComponent(0.5)
        default:
            break
        }
    }

}
