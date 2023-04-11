//
//  RegisterViewController.swift
//  ToDoApp
//
//  Created by 최용헌 on 2023/04/11.
//

import UIKit

class RegisterViewController: UIViewController {

    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
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
        tf.addTarget(self, action: #selector(ViewController.textFieldEditingChanged(_:)), for: .editingChanged)

        return tf
    }()
    
    private let signUpButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("SIGN UP", for: .normal)
        btn.backgroundColor = UIColor(red: 0.20, green: 0.16, blue: 0.04, alpha: 1.00)
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)

        return btn
    }()
    
    private let loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Log in", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = UIColor(red: 0.81, green: 0.80, blue: 0.76, alpha: 1.00)
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.87, green: 0.86, blue: 0.82, alpha: 1.00)
        
        view.addSubview(signUpLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        view.addSubview(loginButton)

        makeUI()
    }
    
    func makeUI(){
        signUpLabel.snp.makeConstraints { make in
            make.bottom.equalTo(emailTextField.snp.top).offset(-50)
            make.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(60)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(60)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
        
    }
    
    @objc func loginButtonTapped(){
        print("로그인버튼이 눌렸습니다")
        
    }
    
    @objc func registerButtonTapped(){
        let alert = UIAlertController(title: "등록하기", message: "계정을 등록하시겠습니까?", preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default){ action in
            print("확인버튼이 눌렸습니다.")
        }
        let cancel = UIAlertAction(title: "취소", style: .default) { cancel in
            print("취소버튼이 눌렸습니다.")
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
 
}
