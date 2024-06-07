//
//  WelcomeViewController.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/07.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let welcomeView = WelcomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        goToMain()
    }
    
    override func loadView() {
        view = welcomeView
    }
    
    // MARK: - set toMainButton
    private func goToMain() {
        welcomeView.toMainButton.addTarget(self, action: #selector(tappedTomainButton), for: .touchUpInside)
    }
    
    @objc func tappedTomainButton() {
        let homeVC = PageViewController()
        navigationController?.pushViewController(homeVC, animated: true)
    }
}
