//
//  ViewController.swift
//  ToDoList
//
//  Created by 최용헌 on 2023/04/08.
//
import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Log In"
        label.font = UIFont.systemFont(ofSize: 44, weight: .bold)
        return label
    }()
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.layer.cornerRadius = 15
        tf.backgroundColor = .white
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = .white
        tf.frame.size.height = 48
        tf.textColor = .black
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true
        tf.layer.cornerRadius = 15
        tf.clearsOnBeginEditing = false
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)

        return tf
    }()
    
    private let loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("LOG IN", for: .normal)
        btn.backgroundColor = UIColor(red: 0.20, green: 0.16, blue: 0.04, alpha: 1.00)
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    private let registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .systemGray2
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    private let forgotPasswordButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Forgot Password?", for: .normal)
        btn.setTitleColor(.black ,for: .normal)
        return btn
        
    }()
    
    private let forgotPasswordImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bottomImage")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        
        view.addSubview(emailTextField)
        view.addSubview(loginLabel)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(forgotPasswordImageView)

        makeUI()
    }
    
    func makeUI(){
        // 이메일 텍스트 필드 설정
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(60)
        }
        // 로그인 라벨 설정
        loginLabel.snp.makeConstraints { make in
            make.bottom.equalTo(emailTextField.snp.top).offset(-50)
            make.centerX.equalToSuperview()
        }
        // 비밀번호 텍스트 필드 설정
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(60)
        }
        
        // 로그인 버튼 설정
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
        
        // 회원가입 버튼 설정
        registerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
        
        // 비밀번호 찾기 버튼 설정
        forgotPasswordButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(registerButton.snp.bottom).offset(10)
        }
        
        // 이미지 뷰 설정
        forgotPasswordImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(10)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    @objc func textFieldEditingChanged(_ textField : UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
            loginButton.backgroundColor = .clear
            loginButton.isEnabled = false
            return
        }
        loginButton.backgroundColor = .red
        loginButton.isEnabled = true
        
        
    }
    
}
#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    
func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
}
@available(iOS 13.0.0, *)
func makeUIViewController(context: Context) -> UIViewController{
    ViewController()
    }
}
@available(iOS 13.0, *)
struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            if #available(iOS 14.0, *) {
                ViewControllerRepresentable()
                    .ignoresSafeArea()
                    .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
                    .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
} #endif
