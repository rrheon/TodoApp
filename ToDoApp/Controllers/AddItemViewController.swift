import UIKit

import SnapKit

protocol AddItemDelegate: AnyObject {
    func addItem(item: Info)
}

final class AddItemViewController: UIViewController {
    weak var delegate: AddItemDelegate?
        
    private let completedLabel: UILabel = {
        let label = UILabel()
        label.text = "Completed"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let priorityLabel: UILabel = {
        let label = UILabel()
        label.text = "Priority"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let deadLineLabel: UILabel = {
        let label = UILabel()
        label.text = "Deadline"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let memoLabel: UILabel = {
        let label = UILabel()
        label.text = "Note"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var completedSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = true
        return sw
    }()
    
    private let titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "제목을 입력하세요"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    let priorityChoice: UISegmentedControl = {
        let items = PriorityOptions.allCases.map { $0.rawValue }
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let deadLineDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.minimumDate = Date()
        return picker
    }()
    
    private let memoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter memo"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setNavigationbar()
        setupLayout()
        makeUI()
    }
    // MARK: - navigationbar 설정
    func setNavigationbar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addItem))
    }
    // MARK: - view 계층 설정
    func setupLayout(){
        [
            completedLabel,
            titleLabel,
            priorityLabel,
            deadLineLabel,
            memoLabel,
            completedSwitch,
            priorityChoice,
            memoTextField,
            titleTextField,
            deadLineDatePicker
        ].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - layout 설정
    func makeUI() {
        completedLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        completedSwitch.snp.makeConstraints { make in
            make.top.equalTo(completedLabel)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(completedLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalTo(memoLabel).offset(50)
        }
        
        priorityLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel)
        }
        
        priorityChoice.snp.makeConstraints { make in
            make.top.equalTo(priorityLabel)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        deadLineLabel.snp.makeConstraints { make in
            make.top.equalTo(priorityLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel)
        }
        
        deadLineDatePicker.snp.makeConstraints { make in
            make.top.equalTo(deadLineLabel)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalTo(deadLineLabel).offset(10)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(deadLineLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel)
        }
        
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(memoLabel)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalTo(memoLabel).offset(50)
        }
    }
}

// MARK: - 함수
extension AddItemViewController {
    @objc func addItem() {
        let newItem = Info(title: emptyCheck(titleTextField),
                           priority: PriorityOptions.allCases[priorityChoice.selectedSegmentIndex].rawValue,
                           memo: emptyCheck(memoTextField),
                           date: convertDate(),
                           isCompleted: switchChanged(completedSwitch))

        delegate?.addItem(item: newItem)

        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 공백확인 함수
    func emptyCheck(_ textField: UITextField) -> (String) {
        guard let info = textField.text, !info.isEmpty else {
            let alert = UIAlertController(title: "Error",
                                          message: "Please enter some information",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return "No infomation"
        }
        return info
    }

    // MARK: - 날짜 -> String 변환함수
    func convertDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let deadLine = dateFormatter.string(from: deadLineDatePicker.date)
        return deadLine
    }

    // MARK: - 스위치 true/false 전달함수
    func switchChanged(_ sender: UISwitch) -> Bool {
        if sender.isOn {
            return true
        } else {
            return false
        }
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
        AddItemViewController()
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
