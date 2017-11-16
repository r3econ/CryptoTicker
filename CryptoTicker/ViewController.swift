//
//  ViewController.swift
//  CryptoTicker
//
//  Created by Rafał on 16.11.17.
//  Copyright © 2017 mycompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var valueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string:"https://blockchain.info/ticker")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    self.valueLabel.text = "error"
                }
                return
            }

            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            let tickerList = try! decoder.decode(TickerList.self, from: data)

            DispatchQueue.main.async {
                self.valueLabel.text = String(format: "%@%.0f", tickerList.eur.currencySymbol, tickerList.eur.recentMarketPrice)
            }
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

