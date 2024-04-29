//
//  HomeViewController.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case Main, MustSeen, PopularLive, AD
    }
    
    // MARK: - properties
    private let rootView = HomeView()
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    private var mainContents = MainContent.list
    private var mustSeenContents = MustSeenContent.list
    
    // MARK: - initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialAttributes()
    }
    
    // MARK: - set initial attributes
    private func setInitialAttributes() {
        view = rootView
        
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
            case .MustSeen:
                itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.26), heightDimension: .estimated(180))
            case .PopularLive:
                itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1.0))
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
            case .AD:
                itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
            }
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0)
            
            if sectionLayoutKind == .Main {
                section.orthogonalScrollingBehavior = .groupPagingCentered
            } else if sectionLayoutKind == .MustSeen {
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(20))
                let headerSupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                section.boundarySupplementaryItems = [headerSupplementaryItem]
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0)
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
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MustSeenCell", for: indexPath) as? MustSeenCell else { return UICollectionViewCell() }
                cell.dataBind(mustSeenContent)
                return cell
//                            case let popularLiveContent as PopularLiveContent:
                //            case let adContent as ADContent:
            default:
                return nil
            }
        })
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.rootView.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MustSeenHeader", for: index)
        }
        
        putsnapshotData()
    }
    
    private func putsnapshotData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(mainContents, toSection: .Main)
        snapshot.appendItems(mustSeenContents, toSection: .MustSeen)
        dataSource.apply(snapshot)
    }
}

