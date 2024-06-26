//
//  FreeContent.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/30.
//

import UIKit

struct FreeContent: Hashable {
    let contentImage: UIImage
    let contentName: String
    let uuid = UUID()
}

extension FreeContent {
    static let list = [
        MustSeenContent(contentImage: UIImage(named: "signal")!, contentName: "시그널"),
        MustSeenContent(contentImage: UIImage(named: "yourname")!, contentName: "너의 이름은"),
        MustSeenContent(contentImage: UIImage(named: "signal")!, contentName: "시그널"),
        MustSeenContent(contentImage: UIImage(named: "kingring")!, contentName: "반지의 제왕"),
        MustSeenContent(contentImage: UIImage(named: "signal")!, contentName: "시그널"),
        MustSeenContent(contentImage: UIImage(named: "harrypotter")!, contentName: "해리포터"),
        MustSeenContent(contentImage: UIImage(named: "signal")!, contentName: "시그널"),
        MustSeenContent(contentImage: UIImage(named: "doorcheck")!, contentName: "스즈메의 문단속")
    ]
}
