//
//  LoginView.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/07.
//

import UIKit
import Then
import SnapKit

class LoginView: UIView {
    // MARK: - create components
    private let titleLabel = UILabel()
    let idTextField = UITextField()
    let passwordField = UITextField()
    lazy var clearTextButtonForID = UIButton()
    lazy var clearTextButtonForPW = UIButton()
    lazy var passwordEyeButton = UIButton()
    lazy var loginButton = UIButton()
    let warningMessage = UILabel()
    lazy var findId = UIButton()
    lazy var findPassword = UIButton()
    let createAccountSubsLabel = UILabel()
    lazy var createNickNameButton = UIButton()
    private let borderLine = UIView()
    private let forResizeView = UIView()
    private let findStackView = UIStackView()
    private let createAccountStackView = UIStackView()
    
    // MARK: - initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set components attributes
    private func setUI() {
        backgroundColor = .black
        
        [findId, forResizeView, findPassword]
            .forEach { findStackView.addArrangedSubview($0) }
        
        forResizeView.addSubview(borderLine)
        
        [createAccountSubsLabel, createNickNameButton]
            .forEach { createAccountStackView.addArrangedSubview($0) }
        
        [titleLabel, idTextField, passwordField, clearTextButtonForID, clearTextButtonForPW, passwordEyeButton, loginButton, warningMessage, findStackView, createAccountStackView]
            .forEach { addSubview($0) }
        
        titleLabel.do {
            $0.text = "TVING ID 로그인"
            $0.textColor = .white
            $0.font = .boldSystemFont(ofSize: 25)
        }
        
        idTextField.do {
            $0.backgroundColor = .darkGray
            $0.textColor = .white
            $0.placeholder = "아이디"
            $0.setPlaceHolder(color: .lightGray)
            $0.layer.cornerRadius = 5
            $0.addPadding(left: 12, right: 12)
        }
        
        passwordField.do {
            $0.backgroundColor = .darkGray
            $0.textColor = .white
            $0.placeholder = "비밀번호"
            $0.setPlaceHolder(color: .lightGray)
            $0.layer.cornerRadius = 5
            $0.addPadding(left: 12, right: 12)
            $0.isSecureTextEntry = true
        }
        
        clearTextButtonForID.do {
            $0.setImage(UIImage.init(systemName: "x.circle"), for: .normal)
            $0.tintColor = .lightGray
            $0.isHidden = true
        }
        
        clearTextButtonForPW.do {
            $0.setImage(UIImage.init(systemName: "x.circle"), for: .normal)
            $0.tintColor = .lightGray
            $0.isHidden = true
        }
        
        passwordEyeButton.do {
            $0.setImage(UIImage.init(systemName: "eye.slash"), for: .normal)
            $0.tintColor = .lightGray
            $0.isHidden = true
        }
        
        warningMessage.do {
            $0.text = "올바르지 않은 이메일 형식입니다."
            $0.textColor = .red.withAlphaComponent(0.8)
            $0.font = .systemFont(ofSize: 12)
            $0.isHidden = true
        }
        
        loginButton.do {
            $0.backgroundColor = .none
            $0.setTitle("로그인하기", for: .normal)
            $0.setTitleColor(.lightGray, for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 18)
            $0.layer.cornerRadius = 3
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.isEnabled = false
        }
        
        findStackView.do {
            $0.axis = .horizontal
            $0.spacing = 30
        }
        
        findId.do {
            $0.backgroundColor = .none
            $0.setTitle("아이디 찾기", for: .normal)
            $0.setTitleColor(.lightGray, for: .normal)
        }
        
        findPassword.do {
            $0.backgroundColor = .none
            $0.setTitle("비밀번호 찾기", for: .normal)
            $0.setTitleColor(.lightGray, for: .normal)
        }
        
        createAccountStackView.do {
            $0.axis = .horizontal
            $0.spacing = 20
        }
        
        createAccountSubsLabel.do {
            $0.text = "아직 계정이 없으신가요?"
            $0.textColor = .darkGray
            $0.font = .systemFont(ofSize: 15)
        }
        
        createNickNameButton.do {
            let title = "닉네임 만들러가기"
            $0.setUnderLine(title: title)
            $0.setTitleColor(.lightGray, for: .normal)
            $0.backgroundColor = .none
        }
        
        forResizeView.do { $0.backgroundColor = .none }
        
        borderLine.do { $0.backgroundColor = .darkGray }
    }
    
    // MARK: - set components layout
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        clearTextButtonForID.snp.makeConstraints {
            $0.centerY.equalTo(idTextField)
            $0.trailing.equalTo(idTextField).offset(-15)
        }
        
        passwordField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        passwordEyeButton.snp.makeConstraints {
            $0.centerY.equalTo(passwordField)
            $0.trailing.equalTo(passwordField).offset(-15)
        }
        
        clearTextButtonForPW.snp.makeConstraints {
            $0.centerY.equalTo(passwordField)
            $0.trailing.equalTo(passwordEyeButton.snp.leading).offset(-15)
        }
        
        warningMessage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(passwordField.snp.bottom).offset(10)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(warningMessage.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        findStackView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(75)
            $0.height.equalTo(22)
        }
        
        borderLine.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5)
            $0.width.equalTo(0.5)
        }
        
        createAccountStackView.snp.makeConstraints {
            $0.top.equalTo(findStackView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(45)
        }
    }
}

