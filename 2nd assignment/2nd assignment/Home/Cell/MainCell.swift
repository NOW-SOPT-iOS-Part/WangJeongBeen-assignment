//
//  MainCell.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/25.
//

import UIKit
import SnapKit
import Then

class MainCell: UICollectionViewCell {
    
    // MARK: - properties
    private let contentImage = UIImageView()
    
    // MARK: - initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set UI
    private func setUI() {
        addSubview(contentImage)
        
        contentImage.do {
            $0.contentMode = .scaleAspectFill
        }
    }
    
    private func setLayout() {
        contentImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MainCell {
    func dataBind(_ content: MainContent) {
        contentImage.image = content.contentImage
    }
}
