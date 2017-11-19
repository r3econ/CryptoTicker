//
//  WebServiceProxy.swift
//  CryptoTicker
//
//  Created by Rafał on 19.11.17.
//  Copyright © 2017 mycompany. All rights reserved.
//

import Foundation

enum WebserviceError: Error {
    case noData
}

class WebServiceProxy {
    
    typealias FailureHandler = ((Error)->())
    typealias SuccessHandler<Value> = ((Value)->())
    
    func getTicker(success:@escaping SuccessHandler<TickerList>, failure: @escaping FailureHandler) {
        let url = URL(string:"https://blockchain.info/ticker")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    failure(error!)
                }
                return
            }
            
            guard let data = data else {
                failure(WebserviceError.noData)
                return
            }
            
            let decoder = JSONDecoder()
            let tickerList = try! decoder.decode(TickerList.self, from: data)
            
            DispatchQueue.main.async {
                success(tickerList)
            }
            }.resume()
    }
}

