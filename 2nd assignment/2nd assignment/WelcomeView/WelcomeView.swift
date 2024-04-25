//
//  WelcomeView.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/07.
//

import UIKit
import Then
import SnapKit

class WelcomeView: UIView {
    
    // MARK: - create components
    private let imageView = UIImageView()
    let welcomeLabel = UILabel()
    lazy var toMainButton = UIButton()

    // MARK: - initalize
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
        
        [imageView, welcomeLabel, toMainButton]
            .forEach { addSubview($0) }
        
        imageView.do {
            $0.image = UIImage(named: "tvingTitle")
        }
        
        welcomeLabel.do {
            $0.text = "saefdsafos"
            $0.numberOfLines = 2
            $0.textAlignment = .center
            $0.font = .boldSystemFont(ofSize: 25)
            $0.textColor = .white
        }
        
        toMainButton.do {
            $0.setTitle("메인으로", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .red
            $0.layer.cornerRadius = 3
        }
    }
    
    // MARK: - set components layout
    private func setLayout() {
        imageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(210)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        toMainButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(15)
            $0.height.equalTo(52)
        }
    }
}
