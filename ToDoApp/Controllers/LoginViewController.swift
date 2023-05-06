//
//  ViewController.swift
//  ToDoList
//
//  Created by 최용헌 on 2023/04/08.
//
import UIKit

import SnapKit

final class LoginViewController: UIViewController {
  private let loginLabel: UILabel = {
    let label = UILabel()
    label.text = "Log In"
    label.font = UIFont.systemFont(ofSize: 44, weight: .bold)
    return label
  }()
  
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
  
  private lazy var loginButton: UIButton = {
    let btn = UIButton()
    btn.setTitle("LOG IN", for: .normal)
    btn.backgroundColor = Color.loginButtonBackground.uiColor
    btn.layer.cornerRadius = 15
    btn.isEnabled = false
    btn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    return btn
  }()
  
  private lazy var registerButton: UIButton = {
    let btn = UIButton()
    btn.setTitle("Sign Up", for: .normal)
    btn.setTitleColor(.black, for: .normal)
    btn.backgroundColor = Color.registerButtonBackground.uiColor
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
  
  private let bottomImage: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "bottomImage")
    return view
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
      emailTextField,
      loginLabel,
      passwordTextField,
      loginButton,
      registerButton,
      forgotPasswordButton,
      bottomImage
    ].forEach {
      view.addSubview($0)
    }
  }
  
  // MARK: - layout 설정
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
    bottomImage.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(forgotPasswordButton.snp.bottom).offset(10)
    }
  }
  
  // MARK: - button action function
  @IBAction func registerButtonTapped(_ sender: UIButton){
    let nextVC = RegisterViewController()
    nextVC.modalPresentationStyle = .fullScreen
    self.present(nextVC, animated: true)
  }
  
  @objc func loginButtonTapped(){
    let nextVC = MainViewController()
    nextVC.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(nextVC, animated: true)
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

// MARK: - padding 추가함수
extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
// MARK: - ID, password 미입력 시 버튼 비활성화 함수
extension LoginViewController {
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
      loginButton.backgroundColor = Color.loginButtonBackground.uiColor
      loginButton.isEnabled = false
      return
    }
    loginButton.backgroundColor = Color.loginButtonActiveBackground.uiColor
    loginButton.isEnabled = true
  }
  
}
