//
//  HomeViewModel.swift
//  2nd assignment
//
//  Created by 왕정빈 on 6/6/24.
//

import Foundation
import RxSwift

final class HomeViewModel {
    
    let mainContents = MainContent.list
    let mustSeenContents = MustSeenContent.list
    let popularLiveContents = PopularLiveContent.list
    let freeContents = FreeContent.list
    let adContents = ADContent.list
    var magicContents = PublishSubject<[DailyBoxOfficeList]>()
    
    func fetchMovieName() {
        MovieService.shared.getMovieName(date: "20240509") { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data as? MagicContent else { return }
                self.magicContents.onNext(data.boxOfficeResult.dailyBoxOfficeList)
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
