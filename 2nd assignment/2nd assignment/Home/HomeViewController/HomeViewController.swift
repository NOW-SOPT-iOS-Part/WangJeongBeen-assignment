//
//  HomeViewController.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/25.
//

import UIKit
import RxSwift

protocol ScrollDelegate: AnyObject {
    func navigationIsHidden(_ isHidden: Bool)
}

class HomeViewController: UIViewController {
    
    // MARK: - properties
    private let rootView = HomeView()
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
//    private let currentBannerPage = PublishSubject<Int>()
    private let mainContents = MainContent.list
    private let mustSeenContents = MustSeenContent.list
    private let popularLiveContents = PopularLiveContent.list
    private let freeContents = FreeContent.list
    private let adContents = ADContent.list
    private var magicContents: [DailyBoxOfficeList] = []
    weak var delegate: ScrollDelegate?
    
    // MARK: - initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestMovieName()
        setInitialAttributes()
    }
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    // MARK: - set initial attributes
    private func setInitialAttributes() {
        rootView.homeCollectionView.contentInsetAdjustmentBehavior = .never
        rootView.homeCollectionView.delegate = self
        configureCollectionView()
    }
    
    // MARK: - set collectionView attributes
    private func configureCollectionView() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: rootView.homeCollectionView, cellProvider: { collectionView, indexPath, item in
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
            case let magicContent as DailyBoxOfficeList:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesContentCell", for: indexPath) as? SeriesContentCell else { return UICollectionViewCell() }
                cell.magicDataBind(magicContent)
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
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: index) as? SectionHeader else { return UICollectionReusableView() }
                
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
                
            case UICollectionView.elementKindSectionFooter:
                guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SectionFooter", for: index) as? SectionFooter else { return UICollectionReusableView() }
//                footerView.bind(input: self.currentBannerPage.asObservable())
                footerView.dataBind()
                return footerView
            default:
                return UICollectionReusableView()
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

extension HomeViewController: UICollectionViewDelegate {
    //스크롤 시 최상단에서만 navigationBar 나타남, navigationBar 유무에 따라서 색 변경
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let navigationIsHidden = scrollView.contentOffset.y > 0
        navigationController?.setNavigationBarHidden(navigationIsHidden, animated: false)
        delegate?.navigationIsHidden(navigationIsHidden)
    }
}

// MARK: - Network

extension HomeViewController {
    func requestMovieName() {
        MovieService.shared.getMovieName(date: "20240509") { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data as? MagicContent else { return }
                self.magicContents = data.boxOfficeResult.dailyBoxOfficeList
                DispatchQueue.main.async {
                    self.putsnapshotData()
                }
            case .requestErr:
                print("요청 오류 입니다")
            case .decodedErr:
                print("디코딩 오류 입니다")
            case .pathErr:
                print("경로 오류 입니다")
            case .serverErr:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
        }
    }
}
