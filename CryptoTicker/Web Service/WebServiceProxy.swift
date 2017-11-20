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

/// Class representing web service interface
class WebServiceProxy {
    
    /// Generic request failure handler
    typealias FailureHandler = ((Error)->())
    
    /// Generic request success handler
    typealias SuccessHandler<Value> = ((Value)->())
    
    /// Performs GET request and decodes response trying to create an object
    func getObject<Value: Decodable>(at url: URL,
                                     success:@escaping SuccessHandler<Value>,
                                     failure: @escaping FailureHandler) {
        // Create data task
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle error
            guard error == nil else {
                // Run failure handler on the main thread
                DispatchQueue.main.async {
                    failure(error!)
                }
                return
            }
            
            // No data received
            guard let data = data else {
                // Run failure handler on the main thread
                DispatchQueue.main.async {
                    failure(WebserviceError.noDataReceived)
                }
                return
            }
            
            // Decode the response
            do {
                let decodedObject = try JSONDecoder().decode(Value.self, from: data)
                // Call success handler
                DispatchQueue.main.async {
                    success(decodedObject)
                }
            } catch let error {
                // Run failure handler on the main thread
                DispatchQueue.main.async {
                    failure(error)
                }
            }
            }.resume()
    }

}

