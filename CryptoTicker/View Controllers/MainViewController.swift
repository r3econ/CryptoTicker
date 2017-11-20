//
//  MainViewController.swift
//  CryptoTicker
//
//  Created by Rafał on 16.11.17.
//  Copyright © 2017 mycompany. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var valueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let webService = WebServiceProxy()
        
        webService.getTicker(success: { tickerList in
            self.valueLabel.text = String(format: "%@%.0f", tickerList.eur.currencySymbol, tickerList.eur.recentMarketPrice)
        }, failure: { error in
            self.valueLabel.text = "error"
        })
    }
}
