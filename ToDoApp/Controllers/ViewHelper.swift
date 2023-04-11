//
//  ViewHelper.swift
//  ToDoApp
//
//  Created by 최용헌 on 2023/04/15.
//
import UIKit

@objc func loginButtonTapped(){
    let nextVC = MainViewController()
    nextVC.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(nextVC, animated: true)
//        self.present(nextVC, animated: true)
}
