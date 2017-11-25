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

import XCTest
@testable import CryptoTicker

class ResponseParsingTests: XCTestCase {
    
    private var responseData: Data!
    private var decoder = JSONDecoder()

    override func setUp() {
        super.setUp()
        
        // Load sample response data
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "ticker_response", ofType: "json")!
        self.responseData = try! Data(contentsOf: URL(fileURLWithPath: path))
    }
    
    func testParsingResponseData() {
        do {
            // Parse the response data
            let tickerList: TickerList = try self.decoder.decode(TickerList.self, from: self.responseData)
            // Check if value got parsed correctly
            XCTAssertEqual(tickerList.usd.recentMarketPrice, 8233.52)
        } catch {
            XCTFail()
        }
    }
    
}
