//
//  MainViewController.swift
//  ToDoApp
//
//  Created by 최용헌 on 2023/04/11.
//
import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "홈"
        self.view.backgroundColor = .white
        
        // 네비게이션 아이템 추가
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(goToProfileVC))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "message.fill"), style: .plain, target: self, action: #selector(goToMessageVC))
        
                
    }
    
    
    @objc fileprivate func goToProfileVC(){
        print("MainViewController - goToProfileVC() 호출됨")
        
        let profileVC = LoginViewController()
        self.navigationController?.pushViewController(profileVC, animated: true)
        profileVC.modalPresentationStyle = .fullScreen
//        self.present(profileVC, animated: true)
        
    }
    
    @objc fileprivate func goToMessageVC(){
        print("MainViewController - goToMessageVC() 호출됨")
        
//        let messageVC = MessageViewController()
//        self.navigationController?.pushViewController(messageVC, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(goToProfileVC))

    }

}

