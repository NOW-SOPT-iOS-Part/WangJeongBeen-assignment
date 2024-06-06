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
    let homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
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
        
        addSubview(homeCollectionView)
        
        homeCollectionView.do {
            $0.backgroundColor = .black
            $0.collectionViewLayout = collectionViewLayout()
            $0.register(MainCell.self, forCellWithReuseIdentifier: "MainCell")
            $0.register(SeriesContentCell.self, forCellWithReuseIdentifier: "SeriesContentCell")
            $0.register(PopularLiveCell.self, forCellWithReuseIdentifier: "PopularLiveCell")
            $0.register(ADCell.self, forCellWithReuseIdentifier: "ADCell")
            $0.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
            $0.register(SectionFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SectionFooter")
        }
    }
    
    private func setLayout() {
        homeCollectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let sectionLayoutKind = Section(rawValue: sectionIndex) else { return nil }
            
            let itemSize: NSCollectionLayoutSize
            let groupSize: NSCollectionLayoutSize
            
            switch sectionLayoutKind {
            case .Main:
                itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(520))
            case .MustSeen, .FreeContent, .MagicContent:
                itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.26), heightDimension: .estimated(180))
            case .PopularLive:
                itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.42), heightDimension: .estimated(130))
            case .AD:
                itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
            }
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            if sectionLayoutKind == .Main {
                let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
                let footerSupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: footerSize,
                    elementKind: UICollectionView.elementKindSectionFooter,
                    alignment: .bottom
                )
                section.boundarySupplementaryItems = [footerSupplementaryItem]
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0)
                
                //compositional Layout 사용시 collectionView안의 section내의 item들이 scroll 됐는지 감지하는 handler
                section.visibleItemsInvalidationHandler = { items, contentOffset, environment in
                    let currentPage = Int(max(0, round(contentOffset.x / environment.container.contentSize.width)))
//                    self.currentBannerPage.onNext(currentPage)
                    NotificationCenter.default.post(name: NSNotification.Name("pageControl"), object: currentPage)
                }
            } else if sectionLayoutKind == .AD {
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0)
            } else {
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(20))
                let headerSupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                section.boundarySupplementaryItems = [headerSupplementaryItem]
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
            }
            return section
        }
        return layout
    }
}
