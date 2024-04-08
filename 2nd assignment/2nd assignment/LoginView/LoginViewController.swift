//
//  ViewController.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/07.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    var id: String?
    var nickName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view = loginView
        
        setDelegate()
        createNickName()
    }
    
    // MARK: - set loginButton
    private func setLoginButton() {
        let loginButton = loginView.loginButton
        loginButton.addTarget(self, action: #selector(pushWelcomeVC), for: .touchUpInside)
        
        if let id = loginView.idTextField.text,
           let password = loginView.passwordField.text {
            if !id.isEmpty && !password.isEmpty {
                self.id = id
                setButtonAttribute(button: loginButton, isEnabled: true, backgroundColor: .red, titleColor: .white)
            } else {
                setButtonAttribute(button: loginButton, isEnabled: false, backgroundColor: nil, titleColor: .lightGray)
            }
        }
    }
    
    @objc func pushWelcomeVC() {
        let welcomeVC = WelcomeViewController()
        if let nickName = nickName {
            welcomeVC.welcomeView.welcomeLabel.text = "\(nickName)님 \n 반가워요!"
            navigationController?.pushViewController(welcomeVC, animated: true)
        } else {
            
        }
    }
    
    private func setButtonAttribute(button: UIButton, isEnabled: Bool, backgroundColor: UIColor?, titleColor: UIColor) {
        button.isEnabled = isEnabled
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
    }
    
    // MARK: - set createNickName
    private func createNickName() {
        loginView.createNickNameButton.addTarget(self, action: #selector(showModalView), for: .touchUpInside)
    }
    
    @objc private func showModalView() {
        let createNickNameVC = CreateNickNameViewController()
        
        if let sheet = createNickNameVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        
        createNickNameVC.dataBind = { [weak self] nickName in
            guard let self = self else { return }
            self.nickName = nickName
        }
        
        self.present(createNickNameVC, animated: true)
    }
    
    // MARK: - additional setting
    private func setDelegate() {
        loginView.idTextField.delegate = self
        loginView.passwordField.delegate = self
    }
}

// MARK: - set textField
extension LoginViewController: UITextFieldDelegate {
    //textField 클릭하면 테두리 변경
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
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
        let eyeButton = loginView.passwordEyeButton
        let clearButtonForID = loginView.clearTextButtonForID
        let clearButtonForPW = loginView.clearTextButtonForPW
        
        updateButtonVisibility(id: idTextfield.text, password: pwTextfield.text)
        
        clearButtonForID.addTarget(self, action: #selector(tappedClearButtonForID), for: .touchUpInside)
        clearButtonForPW.addTarget(self, action: #selector(tappedClearButtonForPW), for: .touchUpInside)
        eyeButton.addTarget(self, action: #selector(tappedEyeButton), for: .touchUpInside)
        
        setLoginButton()
    }
    
    private func updateButtonVisibility(id: String?, password: String?) {
        let isIdEmpty = id?.isEmpty ?? true
        let isPasswordEmpty = password?.isEmpty ?? true
        
        loginView.clearTextButtonForID.isHidden = isIdEmpty
        loginView.clearTextButtonForPW.isHidden = isPasswordEmpty
        loginView.passwordEyeButton.isHidden = isPasswordEmpty
    }
    
    @objc func tappedEyeButton() {
        let eyeButton = loginView.passwordEyeButton
        let passwordField = loginView.passwordField
        
        if passwordField.isSecureTextEntry == true {
            eyeButton.setImage(UIImage.init(systemName: "eye"), for: .normal)
            passwordField.isSecureTextEntry = false
        } else {
            eyeButton.setImage(UIImage.init(systemName: "eye.slash"), for: .normal)
            passwordField.isSecureTextEntry = true
        }
    }
    
    @objc func tappedClearButtonForID() {
        loginView.idTextField.text = ""
        textFieldDidChangeSelection(loginView.idTextField)
    }
    
    @objc func tappedClearButtonForPW() {
        loginView.passwordField.text = ""
        textFieldDidChangeSelection(loginView.passwordField)
    }
}
