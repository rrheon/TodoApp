import UIKit
import SnapKit

final class CustomCell: UITableViewCell {
  // 해당 셀의 identifier 지정
  static let cellId = "CustomCell"
  
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
    titleLabel.numberOfLines = 0
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
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
