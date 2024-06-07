//
//  MainContents.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/29.
//

import UIKit

struct MainContent: Hashable {
    let contentImage: UIImage
    let uuid = UUID()
}

extension MainContent {
    static let list = [
        MainContent(contentImage: UIImage(named: "yourname")!),
        MainContent(contentImage: UIImage(named: "yourname")!),
        MainContent(contentImage: UIImage(named: "yourname")!),
        MainContent(contentImage: UIImage(named: "yourname")!),
        MainContent(contentImage: UIImage(named: "yourname")!),
        MainContent(contentImage: UIImage(named: "yourname")!),
        MainContent(contentImage: UIImage(named: "yourname")!),
        MainContent(contentImage: UIImage(named: "yourname")!)
    ]
}
