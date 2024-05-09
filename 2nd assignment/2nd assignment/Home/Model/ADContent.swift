//
//  ADContent.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/29.
//

import UIKit

struct ADContent: Hashable {
    let adImage: UIImage
}

extension ADContent {
    static let list = [
        ADContent(adImage: UIImage(named: "AD")!)
    ]
}
