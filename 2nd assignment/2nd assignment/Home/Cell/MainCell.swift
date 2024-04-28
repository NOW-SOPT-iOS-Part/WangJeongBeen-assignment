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
    let pageControl = UIPageControl()
    
    // MARK: - initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set UI
    private func setUI() {
        addSubview(contentImage)
        
        contentImage.do {
            $0.contentMode = .scaleAspectFit
        }
        
        pageControl.do {
            $0.numberOfPages = 8
            $0.pageIndicatorTintColor = UIColor(named: "Gray3")
            $0.currentPageIndicatorTintColor = UIColor(named: "Gray1")
        }
    }
    
    private func setLayout() {
        contentImage.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(450)
        }
    }
}
