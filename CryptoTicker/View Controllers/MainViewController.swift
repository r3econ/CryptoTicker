//
//  MainViewController.swift
//  CryptoTicker
//
//  Created by Rafał on 16.11.17.
//  Copyright © 2017 mycompany. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    /// Label showing recent market price
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var errorLabel: UILabel!

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
    }
    
    /// Performs request to get ticker list
    private func performGetTickerListRequest() {
        // Call web service
        self.webService.getTicker(success: { [weak self] tickerList in
            self?.valueLabel.text = String(format: "%@%.0f", tickerList.eur.currencySymbol, tickerList.eur.recentMarketPrice)
        }, failure: { [weak self] error in
            self?.valueLabel.text = "error"
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Pass the ticker when showing settings
        guard segue.destination is SettingsViewController else {
            return
        }
        
        let settingsViewController = segue.destination as! SettingsViewController
        settingsViewController.tickerList = self.tickerList
    }
    
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
    
}
