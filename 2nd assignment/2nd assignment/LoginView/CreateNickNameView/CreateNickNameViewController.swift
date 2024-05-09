//
//  CreateNickNameView.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/09.
//

import UIKit

class CreateNickNameViewController: UIViewController {
    
    // MARK: - properties
    private let createNickNameView = CreateNickNameView()
    
    var dataBind: ((String) -> Void)?
    
    // MARK: - initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSaveButton()
        setInitialSetting()
    }
    
    override func loadView() {
        view = createNickNameView
    }
    
    // MARK: - set Initial Setting
    private func setInitialSetting() {
        view.roundCorners(cornerRadius: 15, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        createNickNameView.nickNameTextField.delegate = self
    }
    
    // MARK: - set SaveButton setting
    private func setSaveButton() {
        let saveButton = createNickNameView.saveButton
        saveButton.addTarget(self, action: #selector(tappedSaveButton), for: .touchUpInside)
    }
    
    @objc private func tappedSaveButton() {
        let nickName = createNickNameView.nickNameTextField.text!
        dataBind?(nickName)
        dismiss(animated: true)
    }
    
    private func setButtonAttribute(button: UIButton, isEnabled: Bool, backgroundColor: UIColor?, titleColor: UIColor) {
        button.isEnabled = isEnabled
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
    }
}

extension CreateNickNameViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let nickName = createNickNameView.nickNameTextField.text ?? ""
        let isEnabled = !nickName.isEmpty
        
        setButtonAttribute(button: createNickNameView.saveButton,
                           isEnabled: isEnabled,
                           backgroundColor: isEnabled ? .red : .white,
                           titleColor: isEnabled ? .white : .lightGray)
    }
}
