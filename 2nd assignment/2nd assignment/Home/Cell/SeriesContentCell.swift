//
//  MustSeenCell.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/25.
//

import UIKit
import SnapKit
import Then

class SeriesContentCell: UICollectionViewCell {
    
    private let contentImage = UIImageView()
    private let contentName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubviews(contentImage, contentName)
        
        contentName.do {
            $0.font = .systemFont(ofSize: 10)
            $0.textColor = .lightGray
        }
    }
    
    private func setLayout() {
        contentImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        contentName.snp.makeConstraints {
            $0.top.equalTo(contentImage.snp.bottom).offset(5)
            $0.leading.equalTo(contentImage).offset(3)
        }
    }
}

extension SeriesContentCell {
    func dataBind(_ content: MustSeenContent) {
        contentImage.image = content.contentImage
        contentName.text = content.contentName
    }
    
    func magicDataBind(_ content: DailyBoxOfficeList) {
        contentImage.image = UIImage(systemName: "person")
        contentName.text = content.movieNm
    }
}
