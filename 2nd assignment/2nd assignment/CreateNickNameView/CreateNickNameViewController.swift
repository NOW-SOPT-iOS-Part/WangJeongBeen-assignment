//
//  CreateNickNameView.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/09.
//

import UIKit

class CreateNickNameViewController: UIViewController {
    
    private let createNickNameView = CreateNickNameView()
    
    var dataBind: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = createNickNameView
        view.layer.cornerRadius = 30
        
        setSaveButton()
    }
    
    private func setSaveButton() {
        let saveButton = createNickNameView.saveButton
        saveButton.addTarget(self, action: #selector(tappedSaveButton), for: .touchUpInside)
    }
    
    @objc private func tappedSaveButton() {
        guard let nickName = createNickNameView.nickNameTextField.text else {
            return dismiss(animated: true)
        }
        dataBind?(nickName)
        dismiss(animated: true)
    }
}
