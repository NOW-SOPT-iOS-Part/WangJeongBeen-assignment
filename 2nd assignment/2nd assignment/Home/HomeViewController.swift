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
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(400))
            case .MustSeen:
                itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0))
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
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
            
            section.interGroupSpacing = 0
            section.orthogonalScrollingBehavior = .groupPagingCentered
            
            return section
        }
        return layout
    }
    
    private func configureCollectionView() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: rootView.collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as? MainCell else { return UICollectionViewCell() }
            cell.dataBind(item as! MainContent)
            return cell
        })
        
        putsnapshotData()
    }
    
    private func putsnapshotData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(mainContents, toSection: .Main)
        dataSource.apply(snapshot)
    }
}

