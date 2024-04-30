//
//  HomeViewController.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case Main, MustSeen, PopularLive, FreeContent, AD, MagicContent
    }
    
    // MARK: - properties
    private let rootView = HomeView()
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    private let mainContents = MainContent.list
    private let mustSeenContents = MustSeenContent.list
    private let popularLiveContents = PopularLiveContent.list
    private let freeContents = FreeContent.list
    private let adContents = ADContent.list
    private let magicContents = MagicContent.list
    
    // MARK: - initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialAttributes()
    }
    
    // MARK: - set initial attributes
    private func setInitialAttributes() {
        view = rootView
        //        rootView.collectionView.delegate = self
        
        rootView.collectionView.contentInsetAdjustmentBehavior = .never
        rootView.collectionView.collectionViewLayout = collectionViewLayout()
        configureCollectionView()
        
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        let mainTitleImage = rootView.mainTitleView.image?.withRenderingMode(.alwaysOriginal)
        let userProfileImage = rootView.userProfile.image?.withRenderingMode(.alwaysOriginal)
        
        let mainTitle = UIBarButtonItem(image: mainTitleImage, style: .plain, target: self, action: .none)
        let userProfile = UIBarButtonItem(image: userProfileImage, style: .plain, target: self, action: .none)
        
        navigationItem.leftBarButtonItem = mainTitle
        navigationItem.rightBarButtonItem = userProfile
        navigationItem.hidesBackButton = true
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    // MARK: - set collectionView attributes
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
    
    private func configureCollectionView() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: rootView.collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            case let mainContent as MainContent:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as? MainCell else { return UICollectionViewCell() }
                cell.dataBind(mainContent)
                return cell
            case let mustSeenContent as MustSeenContent:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesContentCell", for: indexPath) as? SeriesContentCell else { return UICollectionViewCell() }
                cell.dataBind(mustSeenContent)
                return cell
            case let popularLiveContent as PopularLiveContent:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularLiveCell", for: indexPath) as? PopularLiveCell else { return UICollectionViewCell() }
                cell.dataBind(popularLiveContent)
                return cell
            case let adContent as ADContent:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ADCell", for: indexPath) as? ADCell else { return UICollectionViewCell() }
                cell.dataBind(adContent)
                return cell
            default:
                return nil
            }
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, index) in
            
            
            if kind == UICollectionView.elementKindSectionHeader {
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: index) as? SectionHeader else { return nil }
                
                if let sectionLayoutKind = Section(rawValue: index.section) {
                    switch sectionLayoutKind {
                    case .MustSeen:
                        headerView.dataBind(headerTitle: "티빙에서 꼭 봐야하는 콘텐츠")
                    case .PopularLive:
                        headerView.dataBind(headerTitle: "인기 LIVE 채널")
                    case .FreeContent:
                        headerView.dataBind(headerTitle: "1화 무료! 파라마운트+ 인기 시리즈")
                    case .MagicContent:
                        headerView.dataBind(headerTitle: "마술보다 더 신비로운 영화(신비로운 영화사전님)")
                    default:
                        break
                    }
                }
                return headerView
            } else {
                return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SectionFooter", for: index)
            }
        }
        
        
        putsnapshotData()
    }
    
    private func putsnapshotData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(mainContents, toSection: .Main)
        snapshot.appendItems(mustSeenContents, toSection: .MustSeen)
        snapshot.appendItems(popularLiveContents, toSection: .PopularLive)
        snapshot.appendItems(freeContents, toSection: .FreeContent)
        snapshot.appendItems(adContents, toSection: .AD)
        snapshot.appendItems(magicContents, toSection: .MagicContent)
        dataSource.apply(snapshot)
    }
}
