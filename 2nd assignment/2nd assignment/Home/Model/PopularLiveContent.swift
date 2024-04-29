//
//  PopularLiveContent.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/04/29.
//

import UIKit

struct PopularLiveContent: Hashable {
    let liveShowImage: UIColor
    let rankNum: Int
    let channelName: String
    let liveShowName: String
    let watchingRatio: String
}

extension PopularLiveContent {
    static let list = [
        PopularLiveContent(liveShowImage: .white, rankNum: 1, channelName: "Mnet", liveShowName: "보이즈 플래닛 12화", watchingRatio: "80.0%"),
        PopularLiveContent(liveShowImage: .blue, rankNum: 2, channelName: "Mnet", liveShowName: "보이즈 플래닛 12화", watchingRatio: "80.0%"),
        PopularLiveContent(liveShowImage: .gray, rankNum: 3, channelName: "Mnet", liveShowName: "보이즈 플래닛 12화", watchingRatio: "80.0%"),
        PopularLiveContent(liveShowImage: .green, rankNum: 4, channelName: "Mnet", liveShowName: "보이즈 플래닛 12화", watchingRatio: "80.0%"),
        PopularLiveContent(liveShowImage: .red, rankNum: 5, channelName: "Mnet", liveShowName: "보이즈 플래닛 12화", watchingRatio: "80.0%"),
        PopularLiveContent(liveShowImage: .orange, rankNum: 6, channelName: "Mnet", liveShowName: "보이즈 플래닛 12화", watchingRatio: "80.0%"),
        PopularLiveContent(liveShowImage: .purple, rankNum: 7, channelName: "Mnet", liveShowName: "보이즈 플래닛 12화", watchingRatio: "80.0%")
    ]
}
