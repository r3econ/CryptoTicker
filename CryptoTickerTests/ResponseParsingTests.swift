//
//  CryptoTickerTests.swift
//  CryptoTickerTests
//
//  Created by Rafał on 16.11.17.
//  Copyright © 2017 mycompany. All rights reserved.
//

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
