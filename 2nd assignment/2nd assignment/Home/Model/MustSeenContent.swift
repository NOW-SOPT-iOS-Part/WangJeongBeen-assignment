//
//  MustSeenContent.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/29.
//

import UIKit

struct MustSeenContent: Hashable {
    let contentImage: UIImage
    let contentName: String
    let uuid = UUID()
}

extension MustSeenContent {
    static let list = [
        MustSeenContent(contentImage: UIImage(named: "doorCheck")!, contentName: "스즈메의 문단속"),
        MustSeenContent(contentImage: UIImage(named: "doorCheck")!, contentName: "스즈메의 문단속"),
        MustSeenContent(contentImage: UIImage(named: "doorCheck")!, contentName: "스즈메의 문단속"),
        MustSeenContent(contentImage: UIImage(named: "doorCheck")!, contentName: "스즈메의 문단속"),
        MustSeenContent(contentImage: UIImage(named: "doorCheck")!, contentName: "스즈메의 문단속"),
        MustSeenContent(contentImage: UIImage(named: "doorCheck")!, contentName: "스즈메의 문단속"),
        MustSeenContent(contentImage: UIImage(named: "doorCheck")!, contentName: "스즈메의 문단속"),
        MustSeenContent(contentImage: UIImage(named: "doorCheck")!, contentName: "스즈메의 문단속")
    ]
}
