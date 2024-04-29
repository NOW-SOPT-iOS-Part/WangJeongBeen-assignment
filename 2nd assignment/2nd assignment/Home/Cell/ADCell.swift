//
//  ADCell.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/25.
//

import UIKit
import SnapKit
import Then

class ADCell: UICollectionViewCell {
    
    private let adImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubviews(adImage)
    }
    
    private func setLayout() {
        adImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ADCell {
    func dataBind(_ content: ADContent) {
        adImage.image = content.adImage
    }
}
