//
//  WebServiceProxy+Ticker.swift
//  CryptoTicker
//
//  Created by Rafał on 19.11.17.
//  Copyright © 2017 mycompany. All rights reserved.
//

import Foundation

/// Enum describing web service enpoints
enum WebServiceURL: String {
    /// Endpoint with ticker list
    case tickerList = "https://blockchain.info/ticker"
    
    /// Returns endpoint url
    func url() -> URL {
        return URL(string: self.rawValue)!
    }
}

// MARK: - Ticker

extension WebServiceProxy {
    
    /// Performs GET ticker list request
    func getTicker(success:@escaping SuccessHandler<TickerList>, failure: @escaping FailureHandler) {
        self.getObject(at: WebServiceURL.tickerList.url(), success: success, failure: failure)
    }
    
}
