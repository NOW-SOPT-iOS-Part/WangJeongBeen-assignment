//
//  PageViewController.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/05/04.
//

import UIKit

class PageViewController: UIPageViewController {
    
    // MARK: - 프로퍼티
    private let mainTitleView = UIImageView()
    private let userProfile = UIImageView()
    private let topBackgroundView = UIView()
    private let topTabBar = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let indicatorView = UIView()
    private let viewControllerList: [UIViewController] = {
        return [HomeViewController(), LiveViewController(), TVProViewController(), MovieViewController(), ParamountViewController()]
    }()
    private var currentPageNum: Int = 0
    
    // MARK: - initializer
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialSetting()
    }
    
    private func setInitialSetting() {
        setUI()
        setLayout()
        setNavigationBar()
        
        dataSource = self
        delegate = self
        
        if let firstViewController = viewControllerList.first as? HomeViewController {
            firstViewController.delegate = self
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        
    }
    
    // MARK: - NavigationBar 세팅
    private func setNavigationBar() {
        let mainTitleImage = mainTitleView.image?.withRenderingMode(.alwaysOriginal)
        let userProfileImage = userProfile.image?.withRenderingMode(.alwaysOriginal)
        
        let mainTitle = UIBarButtonItem(image: mainTitleImage, style: .plain, target: self, action: .none)
        let userProfile = UIBarButtonItem(image: userProfileImage, style: .plain, target: self, action: .none)
        
        navigationItem.leftBarButtonItem = mainTitle
        navigationItem.rightBarButtonItem = userProfile
        navigationItem.hidesBackButton = true
        
        //navigationBar 투명하게 만들기
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        //스크롤 시 navigationBar 위로 사라짐
        navigationController?.hidesBarsOnSwipe = true
    }
    
    // MARK: - UI 세팅
    private func setUI() {
        view.addSubviews(topBackgroundView, topTabBar, indicatorView)
        
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
        
        indicatorView.do { $0.backgroundColor = .white }
    }
    
    private func setLayout() {
        topTabBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        topBackgroundView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(topTabBar)
        }
        
        indicatorView.snp.makeConstraints {
            $0.leading.equalTo(topTabBar).offset(9.5)
            $0.bottom.equalTo(topTabBar).offset(-10)
            $0.width.equalTo(TabBarItem.list[0].menu.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width)
            $0.height.equalTo(1)
        }
        
        tabBarLayout()
    }
    
    private func tabBarLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        topTabBar.collectionViewLayout = layout
    }
    
    private func moveIndicatorbar(_ targetIndex: Int) {
        let indexPath = IndexPath(item: targetIndex, section: 0)
        topTabBar.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        guard let cell = topTabBar.cellForItem(at: indexPath) as? TabBarCell else { return }
        
        indicatorView.snp.remakeConstraints {
            $0.centerX.equalTo(cell)
            $0.bottom.equalTo(cell)
            $0.width.equalTo(TabBarItem.list[targetIndex].menu.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width)
            $0.height.equalTo(1.5)
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func moveToTargetVC(_ targetIndex: Int) {
        let direction: UIPageViewController.NavigationDirection = currentPageNum > targetIndex ? .reverse : .forward
        setViewControllers([viewControllerList[targetIndex]], direction: direction, animated: true)
        currentPageNum = targetIndex
    }
}

// MARK: - UIPageViewController 세팅
extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllerList.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllerList.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard viewControllerList.count > nextIndex else { return nil }
        
        return viewControllerList[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let targetVC = pendingViewControllers.first,
              let targetIndex = viewControllerList.firstIndex(of: targetVC) else { return }
        
        currentPageNum = targetIndex
        moveIndicatorbar(targetIndex)
    }
    
    //화면 전환이 끝난 후 불려지는 함수
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = viewControllerList.firstIndex(of: currentVC) else { return }
        
        if currentIndex != currentPageNum {
            currentPageNum = currentIndex
            moveIndicatorbar(currentIndex)
        }
    }
}

// MARK: - TopTabBar(CollectionView) 세팅
extension PageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TabBarItem.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabBarCell", for: indexPath) as? TabBarCell else { return UICollectionViewCell() }
        cell.menuLabel.text = TabBarItem.list[indexPath.item].menu
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let tmpLabel : UILabel = UILabel()
//        tmpLabel.text = TabBarItem.list[indexPath.item].menu
//        return CGSize(width: Int(tmpLabel.intrinsicContentSize.width) + 20, height: 30)
        return CGSize(
            width: TabBarItem.list[indexPath.item].menu.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 20,
            height: 30
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moveToTargetVC(indexPath.item)
        moveIndicatorbar(indexPath.item)
        currentPageNum = indexPath.item
    }
}

// MARK: - 스크롤에 따른 상단 바 색깔 변경
extension PageViewController: ScrollDelegate {
    func navigationIsHidden(_ isHidden: Bool) {
        topBackgroundView.backgroundColor = isHidden ? .black : .clear
    }
}
