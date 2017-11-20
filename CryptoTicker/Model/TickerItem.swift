//
//  TickerItem.swift
//  CryptoTicker
//
//  Created by Rafał on 16.11.17.
//  Copyright © 2017 mycompany. All rights reserved.
//

import Foundation

/// Item in the ticker list
struct TickerItem: Codable {
    var recentMarketPrice: Double
    var currencySymbol: String
    
    enum CodingKeys : String, CodingKey {
        case recentMarketPrice = "last"
        case currencySymbol = "symbol"
    }
}
