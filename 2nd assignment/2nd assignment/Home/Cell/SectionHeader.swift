//
//  MustSeenHeader.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/29.
//

import UIKit
import SnapKit
import Then

final class SectionHeader: UICollectionReusableView {
    
    private let headerTitleLabel = UILabel()
    private let seeAllLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubviews(headerTitleLabel, seeAllLabel)
        
        headerTitleLabel.do {
            $0.font = .boldSystemFont(ofSize: 15)
            $0.textColor = .white
        }
        
        seeAllLabel.do {
            $0.text = "전체보기>"
            $0.font = .systemFont(ofSize: 11)
            $0.textColor = .lightGray
        }
    }
    
    private func setLayout() {
        headerTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        seeAllLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-7)
            $0.bottom.equalTo(headerTitleLabel)
        }
    }

}

extension SectionHeader {
    func dataBind(headerTitle: String) {
        headerTitleLabel.text = headerTitle
    }
}
