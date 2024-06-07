//
//  LoginViewModel.swift
//  2nd assignment
//
//  Created by 왕정빈 on 6/6/24.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginViewModel {
    
    var nickName: String?
    var isValidEmail = PublishSubject<Bool>()
    
    func checkValidity(emailID: String) {
        let emailRegEx = "[A-Za-z0-9]+@[A-Za-z0-9]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let isValid = emailTest.evaluate(with: emailID)
        isValidEmail.onNext(isValid)
    }
}
