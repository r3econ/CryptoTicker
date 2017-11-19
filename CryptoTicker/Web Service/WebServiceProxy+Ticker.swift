//
//  WebServiceProxy+Ticker.swift
//  CryptoTicker
//
//  Created by Rafał on 19.11.17.
//  Copyright © 2017 mycompany. All rights reserved.
//

import Foundation

// MARK: - Ticker

extension WebServiceProxy {
    
    func getTicker(success:@escaping SuccessHandler<TickerList>, failure: @escaping FailureHandler) {
        let url = URL(string:"https://blockchain.info/ticker")!
        self.getObject(at: url, success: success, failure: failure)
    }
    
}
