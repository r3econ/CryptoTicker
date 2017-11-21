//
//  MainViewController.swift
//  CryptoTicker
//
//  Created by Rafał on 16.11.17.
//  Copyright © 2017 mycompany. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    /// Time interval between ticker updates
    private let tickerUpdateInterval: TimeInterval = 30
    
    /// Label showing recent market price
    @IBOutlet var valueLabel: UILabel!
    /// Label showing error message
    @IBOutlet var errorLabel: UILabel!

    /// Timer used for updating the ticker
    private var updateTimer: Timer?
    
    /// Ticker list
    private var tickerList: TickerList? {
        didSet {
            self.updateValueLabel()
        }
    }
    
    /// Web service
    private let webService = WebServiceProxy()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the ticker
        self.performGetTickerListRequest()
        
        // Schedule timer
        self.updateTimer = Timer.scheduledTimer(withTimeInterval: self.tickerUpdateInterval, repeats: true, block:{ [weak self] _ in
            // Get the ticker
            self?.performGetTickerListRequest()
        })
    }
    
    /// Performs request to get ticker list
    private func performGetTickerListRequest() {
        // Call web service
        self.webService.getTicker(success: { [weak self] tickerList in
            self?.tickerList = tickerList
        }, failure: { [weak self] error in
            self?.updateErrorLabel(with: error)
        })
    }
    
    /// Update value label
    private func updateValueLabel() {
        guard self.isViewLoaded else {
            return
        }
        
        guard let tickerList = self.tickerList else {
            self.valueLabel.isHidden = true
            return
        }
        
        self.valueLabel.isHidden = false
        self.valueLabel.text = String(format: "%@%.0f", tickerList.eur.currencySymbol, tickerList.eur.recentMarketPrice)
    }
    
    /// Update error label
    private func updateErrorLabel(with error: Error) {
        guard self.isViewLoaded else {
            return
        }
        
        self.errorLabel.isHidden = false
        self.errorLabel.text = error.localizedDescription
    }
    
}
