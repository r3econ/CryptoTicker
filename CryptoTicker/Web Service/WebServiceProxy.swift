//
// Copyright (c) 2017 Rafał Sroka
//
// Licensed under the GNU General Public License, Version 3.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at:
//
//   https://www.gnu.org/licenses/gpl-3.0.en.html
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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

