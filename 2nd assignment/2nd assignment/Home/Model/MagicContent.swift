//
//  MagicContent.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/30.
//

import UIKit

struct MagicContent: Hashable {
    let contentImage: UIImage
    let contentName: String
}

extension MagicContent {
    static let list = [
        MustSeenContent(contentImage: UIImage(named: "harrypotter")!, contentName: "해리포터"),
        MustSeenContent(contentImage: UIImage(named: "harrypotter")!, contentName: "해리포터1"),
        MustSeenContent(contentImage: UIImage(named: "harrypotter")!, contentName: "해리포터2"),
        MustSeenContent(contentImage: UIImage(named: "harrypotter")!, contentName: "해리포터3"),
        MustSeenContent(contentImage: UIImage(named: "harrypotter")!, contentName: "해리포터4"),
        MustSeenContent(contentImage: UIImage(named: "harrypotter")!, contentName: "해리포터5"),
        MustSeenContent(contentImage: UIImage(named: "harrypotter")!, contentName: "해리포터6"),
        MustSeenContent(contentImage: UIImage(named: "harrypotter")!, contentName: "해리포터7")
    ]
}
