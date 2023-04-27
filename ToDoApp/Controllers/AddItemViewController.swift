import UIKit
import SnapKit

let priorityOptions = ["Low", "Medium", "High"]

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
    
    private let deadLabel: UILabel = {
        let label = UILabel()
        label.text = "Deadline"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let noteLabel: UILabel = {
        let label = UILabel()
        label.text = "Note"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var mySwitch : UISwitch = {
        let sw = UISwitch()
        sw.isOn = true
        sw.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        return sw
    }()
    
    private let titleTextField : UITextField = {
        let tf = UITextField()
        tf.frame = CGRect(x: 20, y: 100, width: 200, height: 30)
        tf.placeholder = "제목을 입력하세요"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let prioritySegmentedControl: UISegmentedControl = {
        let items = ["Low", "Medium", "High"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let deadLineDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.frame = CGRect(x: 20, y: 150, width: 200, height: 30)
        picker.datePickerMode = .date
        picker.minimumDate = Date()
        return picker
    }()
    
    private let memoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter memo"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addItem))
        
        [
            completedLabel,
            titleLabel,
            priorityLabel,
            deadLabel,
            noteLabel,
            mySwitch,
            prioritySegmentedControl,
            memoTextField,
            titleTextField,
            deadLineDatePicker
        ].forEach {
            view.addSubview($0)
        }
        
        makeUI()
    }
    
    func makeUI() {
        completedLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        mySwitch.snp.makeConstraints { make in
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
            make.leading.equalTo(noteLabel).offset(50)
            
        }
        
        priorityLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel)
        }
        
        prioritySegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(priorityLabel)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        deadLabel.snp.makeConstraints { make in
            make.top.equalTo(priorityLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel)
        }
        
        deadLineDatePicker.snp.makeConstraints { make in
            make.top.equalTo(deadLabel)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalTo(deadLabel).offset(10)
        }
        
        noteLabel.snp.makeConstraints { make in
            make.top.equalTo(deadLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel)
        }
        
        
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(noteLabel)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalTo(noteLabel).offset(50)
        }
        
    }
    
    
    @objc func addItem() {
        guard let title = titleTextField.text, !title.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please enter a title", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        guard let memo = memoTextField.text, !memo.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please enter a memo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        let priority = priorityOptions[prioritySegmentedControl.selectedSegmentIndex]
        let newItem = Info(title: title, priority: priority, memo: memo)
        delegate?.addItem(item: newItem)
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func switchChanged(_ sender: UISwitch) {
        if sender.isOn {
            print("on")
        } else {
            print("off")
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
