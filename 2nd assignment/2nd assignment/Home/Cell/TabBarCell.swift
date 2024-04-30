//
//  TabBarCell.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/30.
//

import UIKit
import Then
import SnapKit

class TabBarCell: UICollectionViewCell {
    
    let menuLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubviews(menuLabel)
        
        menuLabel.do {
            $0.font = .boldSystemFont(ofSize: 17)
            $0.textColor = .white
            $0.textAlignment = .center
        }
    }
    
    private func setLayout() {
        menuLabel.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
