//
//  RegisterViewController.swift
//  ToDoApp
//
//  Created by 최용헌 on 2023/04/11.
//
import UIKit

final class RegisterViewController: UIViewController {
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = UIFont.systemFont(ofSize: 44, weight: .bold)
        return label
    }()
    
    // MARK: - ID와 Password 입력칸구현
    private lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.layer.cornerRadius = 15
        tf.backgroundColor = .white
        tf.addLeftPadding()
        return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
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
        tf.addLeftPadding()
        return tf
    }()
    
    // MARK: - Button 구현
    private lazy var signUpButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("SIGN UP", for: .normal)
        btn.backgroundColor = Color.loginButtonBackground.uiColor
        btn.layer.cornerRadius = 15
        btn.addTarget(self,
                      action: #selector(registerButtonTapped),
                      for: .touchUpInside)

        return btn
    }()

    private lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("LOG IN", for: .normal)
        btn.backgroundColor = Color.loginButtonBackground.uiColor
        btn.layer.cornerRadius = 15
        btn.addTarget(self,
                      action: #selector(loginButtonTapped),
                      for: .touchUpInside)
    
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.loginScreenBackground.uiColor
        
        setupLayout()
        makeUI()
    }
    
    // MARK: - view 계층 설정
    func setupLayout(){
        [
            signUpLabel,
            emailTextField,
            passwordTextField,
            signUpButton,
            loginButton
        ].forEach {
            view.addSubview($0)
        }
        makeUI()

    }
    // MARK: - layout 설정
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

    // MARK: - button 메서드 구현
    @objc func loginButtonTapped(){
        let nextVC = MainViewController()
        let navController = UINavigationController(rootViewController: nextVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }

    
    @objc func registerButtonTapped(){
        let alert = UIAlertController(title: "등록하기",
                                      message: "계정을 등록하시겠습니까?",
                                      preferredStyle: .alert)
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
 
 
}
