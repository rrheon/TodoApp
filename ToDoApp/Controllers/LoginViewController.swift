//
//  ViewController.swift
//  ToDoList
//
//  Created by 최용헌 on 2023/04/08.
//
import UIKit
import SnapKit

// final 지정해주는 이유
final class LoginViewController: UIViewController {
    // 코드 유지 보수할 때 편하게 작성할것, mark로 구역 나누기
    // private let으로 설정해주는 이유
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Log In"
        label.font = UIFont.systemFont(ofSize: 44, weight: .bold)
        return label
    }()
    
    // private lazy 설정해주는 이유
    private lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.layer.cornerRadius = 15
        tf.backgroundColor = .white
        tf.addLeftPadding()
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)

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
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)

        return tf
    }()
    
    // 로그인 버튼이 활성화 되는거 속성프로퍼티에 넣기 - 코드가 더 깔끔해짐
    private lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("LOG IN", for: .normal)
        btn.backgroundColor = UIColor(red: 0.20, green: 0.16, blue: 0.04, alpha: 1.00)
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        return btn
    }()
//    private let loginButton: UIButton = {
//        var config = UIButton.Configuration.filled()
//        config.title = "LOG IN"
//        let btn = UIButton(configuration: config)
//        btn.configurationUpdateHandler = { btn in
//            switch btn.state {
//            case .normal:
//                btn.configuration?.baseBackgroundColor = UIColor(red: 0.64, green: 0.53, blue: 0.32, alpha: 1.00)
//            case .disabled:
//                btn.configuration?.baseBackgroundColor = UIColor(red: 0.20, green: 0.16, blue: 0.04, alpha: 1.00)
//            default: break
//            }
//        }
//        btn.layer.cornerRadius = 15
//        btn.clipsToBounds = true
//        return btn
//    }()
//
    private lazy var registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = UIColor(red: 0.81, green: 0.80, blue: 0.76, alpha: 1.00)
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)

        return btn
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Forgot Password?", for: .normal)
        btn.setTitleColor(.black ,for: .normal)
        btn.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)

        return btn
        
    }()
    
    private let forgotPasswordImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bottomImage")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.87, green: 0.86, blue: 0.82, alpha: 1.00)
        
        [
            emailTextField,
            loginLabel,
            passwordTextField,
            loginButton,
            registerButton,
            forgotPasswordButton,
            forgotPasswordImageView
        ].forEach {
            view.addSubview($0)
        }
        
        makeUI()
        loginButton.isEnabled = false
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
    
    @IBAction func registerButtonTapped(_ sender: UIButton){
        let nextVC = RegisterViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
        
    }


    @objc func loginButtonTapped(){
        let nextVC = MainViewController()
        nextVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(nextVC, animated: true)
    //        self.present(nextVC, animated: true)
    }
    
    @objc func resetButtonTapped(){
        let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)
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
    
    // mainView에서 logout 시 왼쪽 상단에 back 버튼 숨김
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
}

// 공통으로 사용하는 부분은 따로 빼놓기
extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}

// Delegate를 받고 있지 않음 확인해볼것, 창준형이 준 코드 살펴볼것 - 버튼 관려에 효율적
extension LoginViewController{
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
            loginButton.backgroundColor = UIColor(red: 0.20, green: 0.16, blue: 0.04, alpha: 1.00)
            loginButton.isEnabled = false
            return
        }
        loginButton.backgroundColor = UIColor(red: 0.64, green: 0.53, blue: 0.32, alpha: 1.00)
        loginButton.isEnabled = true
    }
    
}
