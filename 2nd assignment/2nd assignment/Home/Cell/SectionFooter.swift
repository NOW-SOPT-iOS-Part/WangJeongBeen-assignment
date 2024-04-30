//
//  SectionFooter.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/30.
//

import UIKit
import SnapKit
import Then
import RxSwift

class SectionFooter: UICollectionReusableView {
    
    let pageControl = UIPageControl()
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubviews(pageControl)
        
        pageControl.do {
            $0.numberOfPages = MainContent.list.count
            $0.currentPage = 0
            $0.pageIndicatorTintColor = UIColor(named: "Gray3")
            $0.currentPageIndicatorTintColor = UIColor(named: "Gray1")
            $0.isUserInteractionEnabled = false
            $0.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }
    }
    
    private func setLayout() {
        pageControl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-10)
            $0.leading.equalToSuperview().offset(-40)
        }
    }
    
    func bind(input: Observable<Int>) {
        input
            .subscribe(onNext: { [weak self] currentPage in
                self?.pageControl.currentPage = currentPage
            })
            .disposed(by: disposeBag)
    }
}
