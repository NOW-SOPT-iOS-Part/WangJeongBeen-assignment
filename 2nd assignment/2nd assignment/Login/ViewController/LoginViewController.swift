//
//  ViewController.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/07.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let loginView = LoginView()
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        createNickName()
        setAdditionalTextFieldSetting()
        setLoginButton()
    }
    
    override func loadView() {
        view = loginView
    }
    
    // MARK: - set loginButton
    private func setLoginButton() {
        loginView.loginButton.rx.tap
            .bind { [weak self] _ in
                guard let self else { return }
                guard let idText = self.loginView.idTextField.text else { return }
                self.viewModel.checkValidity(emailID: idText)
            }
            .disposed(by: disposeBag)
        
        viewModel.isValidEmail
            .subscribe { [weak self] isValid in
                guard let self else { return }
                if isValid {
                    pushToWelcomViewController()
                } else {
                    self.loginView.warningMessage.isHidden = false
                    self.highlightBorder(loginView.idTextField, color: .red)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func pushToWelcomViewController() {
        let welcomeVC = WelcomeViewController()
        if let nickName = viewModel.nickName {
            welcomeVC.welcomeView.welcomeLabel.text = "\(nickName)님 \n 반가워요!"
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.topItem?.title = ""
            navigationController?.pushViewController(welcomeVC, animated: true)
        } else {
            toMakeNickNameAlert()
        }
    }
    
    private func updateLoginButtonState() {
        let id = loginView.idTextField.text ?? ""
        let password = loginView.passwordField.text ?? ""
        let isEnabled = !id.isEmpty && !password.isEmpty
        setButtonAttribute(button: loginView.loginButton,
                           isEnabled: isEnabled,
                           backgroundColor: isEnabled ? .red : nil,
                           titleColor: isEnabled ? .white : .lightGray
        )
    }
    
    private func setButtonAttribute(button: UIButton, isEnabled: Bool, backgroundColor: UIColor?, titleColor: UIColor) {
        button.isEnabled = isEnabled
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
    }
    
    // MARK: - set createNickName
    
    private func createNickName() {
        loginView.createNickNameButton.rx.tap
            .bind { [weak self] _ in
                guard let self else { return }
                let createNickNameVC = CreateNickNameViewController()
                
                if let sheet = createNickNameVC.sheetPresentationController {
                    sheet.detents = [.medium(), .large()]
                }

                createNickNameVC.nickNameBind
                    .subscribe { nickName in
                        self.viewModel.nickName = nickName
                    }
                    .disposed(by: disposeBag)
                
                self.present(createNickNameVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func toMakeNickNameAlert() {
        let alert = UIAlertController(title: nil, message: "닉네임을 생성하세요", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
    
    // MARK: - additional setting
    private func setDelegate() {
        loginView.idTextField.delegate = self
        loginView.passwordField.delegate = self
    }
    
    private func setAdditionalTextFieldSetting() {
        loginView.clearTextButtonForID.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                loginView.idTextField.text = ""
                textFieldDidChangeSelection(loginView.idTextField)
            }
            .disposed(by: disposeBag)
        
        loginView.clearTextButtonForPW.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                loginView.passwordField.text = ""
                textFieldDidChangeSelection(loginView.passwordField)
            }
            .disposed(by: disposeBag)
        
        loginView.passwordEyeButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                let eyeButton = self.loginView.passwordEyeButton
                let passwordField = self.loginView.passwordField
                
                if passwordField.isSecureTextEntry == true {
                    eyeButton.setImage(UIImage.init(systemName: "eye"), for: .normal)
                    passwordField.isSecureTextEntry = false
                } else {
                    eyeButton.setImage(UIImage.init(systemName: "eye.slash"), for: .normal)
                    passwordField.isSecureTextEntry = true
                }
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - set textField
extension LoginViewController: UITextFieldDelegate {
    //textField 클릭하면 테두리 변경
    func textFieldDidBeginEditing(_ textField: UITextField) {
        highlightBorder(textField, color: .white)
    }
    
    //textField editing 끝나면 테두리 원상태
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
    
    //키보드 return 클릭시 키보드 내려감
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setAdditionalButton()
    }
    
    //화면 터치시 키보드 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setAdditionalButton() {
        let idTextfield = loginView.idTextField
        let pwTextfield = loginView.passwordField
        
        updateButtonVisibility(id: idTextfield.text, password: pwTextfield.text)
        
        updateLoginButtonState()
    }
    
    private func updateButtonVisibility(id: String?, password: String?) {
        guard let id = id else { return }
        guard let password = password else { return }
        
        let isIdEmpty = id.isEmpty
        let isPasswordEmpty = password.isEmpty
        
        loginView.clearTextButtonForID.isHidden = isIdEmpty
        loginView.clearTextButtonForPW.isHidden = isPasswordEmpty
        loginView.passwordEyeButton.isHidden = isPasswordEmpty
    }
    
    func highlightBorder(_ textField: UITextField, color: UIColor) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = color.cgColor
    }
}
