//
//  WebServiceProxy.swift
//  CryptoTicker
//
//  Created by Rafał on 19.11.17.
//  Copyright © 2017 mycompany. All rights reserved.
//

import Foundation

enum WebserviceError: Error {
    case noDataReceived
}

class WebServiceProxy {
    
    typealias FailureHandler = ((Error)->())
    typealias SuccessHandler<Value> = ((Value)->())
    
    func getObject<Value: Decodable>(at url: URL, success:@escaping SuccessHandler<Value>, failure: @escaping FailureHandler) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    failure(error!)
                }
                return
            }
            
            guard let data = data else {
                failure(WebserviceError.noDataReceived)
                return
            }
            
            let decoder = JSONDecoder()
            let decodedObject = try! decoder.decode(Value.self, from: data)
            
            DispatchQueue.main.async {
                success(decodedObject)
            }
            }.resume()
    }

}

