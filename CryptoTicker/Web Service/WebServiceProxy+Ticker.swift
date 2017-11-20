//
//  WebServiceProxy+Ticker.swift
//  CryptoTicker
//
//  Created by Rafał on 19.11.17.
//  Copyright © 2017 mycompany. All rights reserved.
//

import Foundation

enum WebServiceURL: String {
    case tickerList = "https://blockchain.info/ticker"
    
    func url() -> URL {
        return URL(string: self.rawValue)!
    }
}

// MARK: - Ticker

extension WebServiceProxy {
    
    func getTicker(success:@escaping SuccessHandler<TickerList>, failure: @escaping FailureHandler) {
        let url = WebServiceURL.tickerList.url()
        self.getObject(at: url, success: success, failure: failure)
    }
    
}
