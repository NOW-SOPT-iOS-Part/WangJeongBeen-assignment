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
    let topBackgroundView = UIView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let topTabBar = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    // MARK: - initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        tabBarLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set UI
    private func setUI() {
        backgroundColor = .black
        
        addSubviews(topBackgroundView, collectionView, topTabBar)
        bringSubviewToFront(topBackgroundView)
        bringSubviewToFront(topTabBar)
        
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
        
        topTabBar.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(TabBarCell.self, forCellWithReuseIdentifier: "TabBarCell")
            $0.backgroundColor = .none
            $0.showsHorizontalScrollIndicator = false
        }
        
        collectionView.do {
            $0.backgroundColor = .black
            $0.register(MainCell.self, forCellWithReuseIdentifier: "MainCell")
            $0.register(SeriesContentCell.self, forCellWithReuseIdentifier: "SeriesContentCell")
            $0.register(PopularLiveCell.self, forCellWithReuseIdentifier: "PopularLiveCell")
            $0.register(ADCell.self, forCellWithReuseIdentifier: "ADCell")
            $0.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
            $0.register(SectionFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SectionFooter")
        }
    }
    
    private func setLayout() {
        topTabBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        topBackgroundView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(topTabBar)
        }
        
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func tabBarLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        topTabBar.collectionViewLayout = layout
    }
}

extension HomeView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TabBarItem.list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabBarCell", for: indexPath) as? TabBarCell else { return UICollectionViewCell() }
        cell.menuLabel.text = TabBarItem.list[indexPath.item].menu
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let tmpLabel : UILabel = UILabel()
            tmpLabel.text = TabBarItem.list[indexPath.item].menu
            return CGSize(width: Int(tmpLabel.intrinsicContentSize.width) + 20, height: 30)
        }

}
