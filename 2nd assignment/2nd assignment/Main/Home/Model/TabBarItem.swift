//
//  TabBarItem.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/30.
//

import Foundation

struct TabBarItem {
    let menu: String
}

extension TabBarItem {
    static let list = [
        TabBarItem(menu: "홈"),
        TabBarItem(menu: "실시간"),
        TabBarItem(menu: "TV프로그램"),
        TabBarItem(menu: "영화"),
        TabBarItem(menu: "파라마운트+"),
    ]
}
