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
