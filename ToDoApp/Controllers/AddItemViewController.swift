import UIKit

import SnapKit

final class AddItemViewController: UIViewController, UIScrollViewDelegate {
  weak var delegate: AddItemDelegate?
  var itemToEdit: ToDoData?
  
  // 모델(저장 데이터를 관리하는 코어데이터)
  let toDoManager = CoreDataManager.shared
  
  private let topImage: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "checklist")
    return view
  }()
  
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
    sw.onTintColor = Color.priority.uiColor
    return sw
  }()
  
  private lazy var titleTextView: UITextView = {
    let tv = UITextView()
    //    tv.text = "제목을 입력하세요"
    tv.textColor = UIColor.lightGray
    tv.font = UIFont.systemFont(ofSize: 15)
    tv.layer.borderWidth = 1.0
    tv.layer.borderColor = UIColor.lightGray.cgColor
    tv.layer.cornerRadius = 5.0
    tv.adjustUITextViewHeight()
    tv.delegate = self
    return tv
  }()
  
  
  var priorityChoice: UISegmentedControl = {
    let items = PriorityOptions.allCases.map { $0.rawValue }
    let segmentedControl = UISegmentedControl(items: items)
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.selectedSegmentTintColor = Color.priority.uiColor
    return segmentedControl
  }()
  
  
  var deadLineDatePicker: UIDatePicker = {
    let picker = UIDatePicker()
    picker.datePickerMode = .date
    return picker
  }()
  
  private lazy var memoTextView: UITextView = {
    let tv = UITextView()
    //    tv.text = "내용을 입력하세요"
    tv.textColor = UIColor.lightGray
    tv.font = UIFont.systemFont(ofSize: 15)
    tv.layer.borderWidth = 1.0
    tv.layer.borderColor = UIColor.lightGray.cgColor
    tv.layer.cornerRadius = 5.0
    tv.adjustUITextViewHeight()
    tv.delegate = self
    
    return tv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    setNavigationbar()
    setupLayout()
    makeUI()
    checkData()
  }
  
  // MARK: - navigationbar 설정
  func setNavigationbar(){
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                        target: self,
                                                        action: #selector(addItem))
  }
  
  // MARK: - view 계층 설정
  func setupLayout() {
    [
      completedLabel,
      titleLabel,
      priorityLabel,
      deadLineLabel,
      memoLabel,
      completedSwitch,
      priorityChoice,
      memoTextView,
      titleTextView,
      deadLineDatePicker,
      topImage
    ].forEach {
      view.addSubview($0)
    }
  }
  
  // MARK: - layout 설정
  private func makeUI() {
    
    topImage.snp.makeConstraints { make in
      make.height.equalTo(100)
      make.width.equalTo(view.safeAreaLayoutGuide)
      make.centerX.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
    }
    completedLabel.snp.makeConstraints { make in
      make.centerY.equalTo(completedSwitch)
      make.top.equalTo(topImage.snp.bottom).offset(20)
      make.leading.equalToSuperview().offset(20)
    }
    
    completedSwitch.snp.makeConstraints { make in
      make.top.equalTo(completedLabel)
      make.trailing.equalToSuperview().offset(-20)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.centerY.equalTo(titleTextView)
      make.top.equalTo(completedLabel.snp.bottom).offset(10)
      make.leading.equalToSuperview().offset(20)
    }
    
    titleTextView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel)
      make.trailing.equalToSuperview().offset(-20)
      make.leading.equalTo(titleLabel.snp.trailing).offset(10)
      make.width.equalTo(300)
    }
    
    priorityLabel.snp.makeConstraints { make in
      make.centerY.equalTo(priorityChoice)
      make.top.equalTo(titleTextView.snp.bottom).offset(10)
      make.leading.equalTo(titleLabel)
    }
    
    priorityChoice.snp.makeConstraints { make in
      make.top.equalTo(titleTextView.snp.bottom).offset(10)
      make.trailing.equalToSuperview().offset(-20)
    }
    
    deadLineLabel.snp.makeConstraints { make in
      make.centerY.equalTo(deadLineDatePicker)
      make.top.equalTo(priorityLabel.snp.bottom).offset(10)
      make.leading.equalTo(titleLabel)
    }
    
    deadLineDatePicker.snp.makeConstraints { make in
      make.top.equalTo(deadLineLabel)
      make.trailing.equalToSuperview().offset(-20)
      make.leading.equalTo(deadLineLabel).offset(10)
    }
    
    memoLabel.snp.makeConstraints { make in
      make.centerY.equalTo(memoTextView)
      make.top.equalTo(deadLineLabel.snp.bottom).offset(10)
      make.leading.equalTo(titleLabel)
    }
    
    memoTextView.snp.makeConstraints { make in
      make.top.equalTo(memoLabel)
      make.trailing.equalToSuperview().offset(-20)
      make.leading.equalTo(memoLabel.snp.trailing).offset(10)
      make.width.equalTo(300)
    }
  }
}

extension AddItemViewController {
  // MARK: - 기존 데이터 확인
  func checkData() {
    if let itemToEdit = itemToEdit {
      titleTextView.textColor = .black
      memoTextView.textColor = .black
      titleTextView.text = itemToEdit.title
      memoTextView.text = itemToEdit.memo
      
      let datestring = itemToEdit.date
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd"
      if let date = dateFormatter.date(from: datestring ?? "") {
        deadLineDatePicker.date = date
      }
      
      if let priorityOption = PriorityOptions(rawValue: itemToEdit.priority!) {
        let selectedIndex = PriorityOptions.allCases.firstIndex(of: priorityOption) ?? 0
        priorityChoice.selectedSegmentIndex = selectedIndex
      }
      completedSwitch.isOn = itemToEdit.isCompleted
    }
  }
  
  // MARK: - 셀 추가 및 수정
  @objc func addItem() {
    guard let title = nonEmpty(titleTextView.text) else {
      let alert = UIAlertController(title: "Error",
                                    message: "Please enter a title",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
      present(alert, animated: true, completion: nil)
      return
    }
    
    if let item = itemToEdit {
      // 기존의 아이템 수정
      toDoManager.updateToDo(existingToDoData: item,
                             title: title,
                             memo: memoTextView.text,
                             date: Date().convertDateToString(date: deadLineDatePicker.date),
                             isCompleted: completedSwitch.isOn,
                             priority: PriorityOptions.allCases[priorityChoice.selectedSegmentIndex].rawValue){
        self.doneButtonClicked()
      }
      
    } else {
      // 아이템 추가
      toDoManager.saveToDoData(title: title,
                               memo: memoTextView.text,
                               date: Date().convertDateToString(date: deadLineDatePicker.date),
                               isCompleted: completedSwitch.isOn,
                               priority: PriorityOptions.allCases[priorityChoice.selectedSegmentIndex].rawValue) {
        self.doneButtonClicked()
      }
    }
  }
  
  // MARK: - mainview로 이동하는 함수
  @objc func doneButtonClicked() {
    if let viewControllers = navigationController?.viewControllers {
      for vc in viewControllers {
        if let mainVC = vc as? MainViewController {
          navigationController?.popToViewController(mainVC, animated: true)
          break
        }
      }
    }
  }

  // MARK: - 문자열 비었는지 확인
  func nonEmpty(_ str: String) -> String? {
    if str.isEmpty { return nil }
    return str
  }
  
  func nonEmptyTextView(_ tv: UITextView) -> String? {
    return nonEmpty(tv.text)
  }
}

// MARK: - empty 일 때
extension AddItemViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.lightGray {
      textView.text = nil
      textView.textColor = UIColor.black
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "내용을 입력하세요"
      textView.textColor = UIColor.lightGray
    }
  }
}




// MARK: - Preview
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
