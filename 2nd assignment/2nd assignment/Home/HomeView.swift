//
//  HomeView.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/25.
//

import UIKit
import SnapKit
import Then

class HomeView: UIView {
    
    // MARK: - properties
    let mainTitleView = UIImageView()
    let userProfile = UIImageView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
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
        backgroundColor = .black
        
        addSubview(collectionView)
        
        mainTitleView.do {
            $0.image = UIImage(named: "mainTitle")
            $0.contentMode = .scaleAspectFit
            $0.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        }
        
        userProfile.do {
            $0.image = UIImage(named: "userImage")
            $0.contentMode = .scaleAspectFit
            $0.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        }
        
        collectionView.do {
            $0.backgroundColor = .black
            $0.register(MainCell.self, forCellWithReuseIdentifier: "MainCell")
            $0.register(SeriesContentCell.self, forCellWithReuseIdentifier: "SeriesContentCell")
            $0.register(PopularLiveCell.self, forCellWithReuseIdentifier: "PopularLiveCell")
            $0.register(ADCell.self, forCellWithReuseIdentifier: "ADCell")
            $0.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        }
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
