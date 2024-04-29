//
//  PopularLiveCell.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/25.
//

import UIKit
import SnapKit
import Then

class PopularLiveCell: UICollectionViewCell {
    
    private let liveShowImage = UIView()
    private let liveRankLabel = UILabel()
    private let channelLabel = UILabel()
    private let liveShowNameLabel = UILabel()
    private let watchingRatioLabel = UILabel()
    private let liveShowStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        [channelLabel, liveShowNameLabel, watchingRatioLabel]
            .forEach { liveShowStackView.addArrangedSubview($0) }
        
        addSubviews(liveShowImage, liveRankLabel, liveShowStackView)
        
        liveShowStackView.do {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.distribution = .fillEqually
        }
        
        liveRankLabel.do {
            $0.textColor = .white
            $0.font = .boldSystemFont(ofSize: 19)
        }
        
        channelLabel.do {
            $0.textColor = .white
            $0.font = .boldSystemFont(ofSize: 10)
        }
        
        liveShowNameLabel.do {
            $0.textColor = .lightGray
            $0.font = .boldSystemFont(ofSize: 10)
        }
        
        watchingRatioLabel.do {
            $0.textColor = .lightGray
            $0.font = .boldSystemFont(ofSize: 10)
        }
    }
    
    private func setLayout() {
        liveShowImage.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        liveRankLabel.snp.makeConstraints {
            $0.top.equalTo(liveShowImage.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(6)
        }
        
        liveShowStackView.snp.makeConstraints {
            $0.top.equalTo(liveRankLabel)
            $0.leading.equalTo(liveRankLabel.snp.trailing).offset(3)
            $0.trailing.bottom.equalToSuperview()
        }
    }
}

extension PopularLiveCell {
    func dataBind(_ content: PopularLiveContent) {
        liveShowImage.backgroundColor = content.liveShowImage
        liveRankLabel.text = String(content.rankNum)
        channelLabel.text = content.channelName
        liveShowNameLabel.text = content.liveShowName
        watchingRatioLabel.text = content.watchingRatio
    }
}
