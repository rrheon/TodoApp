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
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ToDoList"
        self.view.backgroundColor = .white
    
  
        // TableView 설정
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        // TableView Layout 설정
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
        
        // MARK: - navigationbar 설정
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(goToLoginVC))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTableView))
        
      
        // 데이터 모델 초기화
        items = [
            Info(title:"1",priority: "High", memo: "item 1", date: "2023-04-28"),
            Info(title:"2",priority: "Medium", memo: "item 2", date: "2023-04-29"),
            Info(title:"3",priority: "Low", memo: "item 3", date: "2023-04-30")
        ]
    }
    // MARK: - 메서드 설정
    @objc fileprivate func goToLoginVC() {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
        loginVC.modalPresentationStyle = .fullScreen
    }
    
    @objc fileprivate func addTableView() {
        let addItemVC = AddItemViewController()
        self.navigationController?.pushViewController(addItemVC, animated: true)
        addItemVC.modalPresentationStyle = .fullScreen
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.cellId, for: indexPath) as! CustomCell
        
        // CustomCell에 데이터 전달
        cell.titleLabel.text = items[indexPath.row].title
        cell.deadlineLabel.text = items[indexPath.row].date
        cell.priorityLabel.text = items[indexPath.row].priority
    
        return cell
        
    }

}
