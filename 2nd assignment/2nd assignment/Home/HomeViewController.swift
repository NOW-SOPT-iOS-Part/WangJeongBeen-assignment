//
//  HomeViewController.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - properties
    private let rootView = HomeView()

    // MARK: - initializer
    override func viewDidLoad() {
        super.viewDidLoad()

        setInitialAttributes()
    }
    
    // MARK: - set initial attributes
    private func setInitialAttributes() {
        view = rootView
        navigationItem.hidesBackButton = true
        
        setNavigationItems()
    }
    
    private func setNavigationItems() {
        let mainTitleImage = rootView.mainTitleView.image?.withRenderingMode(.alwaysOriginal)
        let userProfileImage = rootView.userProfile.image?.withRenderingMode(.alwaysOriginal)
        
        let mainTitle = UIBarButtonItem(image: mainTitleImage, style: .plain, target: self, action: .none)
        let userProfile = UIBarButtonItem(image: userProfileImage, style: .plain, target: self, action: .none)
        
        navigationItem.leftBarButtonItem = mainTitle
        navigationItem.rightBarButtonItem = userProfile
    }
}
