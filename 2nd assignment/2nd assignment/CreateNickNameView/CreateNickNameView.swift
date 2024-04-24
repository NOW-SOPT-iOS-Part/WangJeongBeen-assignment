//
//  CreateNickNameView.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/09.
//

import UIKit
import Then
import SnapKit

class CreateNickNameView: UIView {
    
    private let titleLabel = UILabel()
    let nickNameTextField = UITextField()
    lazy var saveButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set UI components attribute
    private func setUI() {
        [titleLabel, nickNameTextField, saveButton]
            .forEach { addSubview($0) }
        
        titleLabel.do {
            $0.text = "닉네임을 입력해주세요"
            $0.textColor = .black
            $0.font = .boldSystemFont(ofSize: 20)
            $0.textAlignment = .left
        }
        
        nickNameTextField.do {
            $0.backgroundColor = .lightGray
            $0.textColor = .black
            $0.layer.cornerRadius = 3
            $0.addPadding(left: 12, right: 12)
        }
        
        saveButton.do {
            $0.setTitle("저장하기", for: .normal)
            $0.setTitleColor(.lightGray, for: .normal)
            $0.backgroundColor = .white
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.borderWidth = 0.5
            $0.layer.cornerRadius = 15
            $0.isEnabled = false
        }
    }
    
    // MARK: - set UI layout
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        saveButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(52)
        }
    }
}
