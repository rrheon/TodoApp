import UIKit
import SnapKit

final class CustomCell: UITableViewCell {
  // 해당 셀의 identifier 지정
  static let cellId = "CustomCell"
  
  // ToDoData를 전달받을 변수
  var toDoData: ToDoData? {
      didSet {
          configureUIwithData()
      }
  }
  // MARK: - cell 구성
  let priorityLabel: UILabel = {
    let label = BasePaddingLabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    label.textColor = .black
    label.textAlignment = .center
    label.layer.cornerRadius = 8
    label.layer.masksToBounds = true
    label.frame.size.width = 30
    return label
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
    label.numberOfLines = 0
    return label
  }()
  
  let deadlineLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()
  
  let completedImageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupLayout()
    makeUI()
  }
  
  // MARK: - view 계층
  func setupLayout(){
    [
      priorityLabel,
      titleLabel,
      deadlineLabel,
      completedImageView,
    ].forEach {
      self.addSubview($0)
    }
  }
  
  // MARK: - layout 설정
  func makeUI(){
    priorityLabel.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(16)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(priorityLabel.snp.bottom).offset(8)
      make.leading.equalTo(priorityLabel)
      make.trailing.equalTo(completedImageView.snp.leading).offset(-16)
      make.bottom.lessThanOrEqualToSuperview().offset(-30)
    }
    
    deadlineLabel.snp.makeConstraints { make in
      make.bottom.equalToSuperview().offset(-8)
      make.leading.equalTo(priorityLabel)
    }
    
    completedImageView.snp.makeConstraints { make in
      make.trailing.equalToSuperview().offset(-16)
      make.centerY.equalTo(priorityLabel)
      make.width.height.equalTo(30)
    }
  }
  
  // MARK: - cell에 데이터 전달
  func configureUIwithData() {
    priorityLabel.text = toDoData?.priority
    deadlineLabel.text = toDoData?.date
    titleLabel.text = toDoData?.title
    
    configureCompletedImageView(toDoData?.isCompleted ?? false)
    if let priorityOption = PriorityOptions(rawValue: priorityLabel.text ?? "") {
      configurePriorityLabel(priorityOption)
    }
  }
  // MARK: - completed 확인함수
  func configureCompletedImageView(_ isCompleted: Bool) {
    if isCompleted {
      completedImageView.image = UIImage(systemName: "checkmark.circle")
      completedImageView.tintColor = UIColor.systemGreen
    } else {
      completedImageView.image = nil
    }
  }
  
  // MARK: - 우선순위확인함수
  func configurePriorityLabel( _ priority: PriorityOptions) {
    switch priority {
    case .low:
      priorityLabel.backgroundColor = PriorityOptions.low.uicolor
    case .medium:
      priorityLabel.backgroundColor = PriorityOptions.medium.uicolor
    case .high:
      priorityLabel.backgroundColor = PriorityOptions.high.uicolor
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
