//
//  UIButton+Extension.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/07.
//

import UIKit

extension UIButton {
    func setUnderLine(title: String?) {
        guard let title = title else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange.init(location: 0, length: title.count))
        setAttributedTitle(attributedString, for: .normal)
    }
}

