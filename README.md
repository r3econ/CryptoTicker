[![Build Status](https://travis-ci.org/r3econ/CryptoTicker.svg?branch=master)](https://travis-ci.org/r3econ/CryptoTicker)
[![License](https://img.shields.io/badge/license-GNU%20GPLv3-brightgreen.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)
![Platform](https://img.shields.io/badge/platform-tvos-lightgrey.svg)

# CryptoTicker
Simple `tvOS` app showing most recent bitcoin price. The app fetches current bitcoin exchange rate from public [Blockchain API](https://blockchain.info/api). Price is updated every `30s`.
![Preview](https://i.imgur.com/sXONNTU.png)

# Technologies used
- Swift
- NSURLSession
- JSON

# Backend API

Price data is fetched from public [Market Prices and Exchanges Rates](https://blockchain.info/api/exchange_rates_api) API.
```json
GET https://blockchain.info/ticker
{
  "USD" : {"15m" : 478.68, "last" : 478.68, "buy" : 478.55, "sell" : 478.68,  "symbol" : "$"},
  "EUR" : {"15m" : 370.13, "last" : 370.13, "buy" : 370.03, "sell" : 370.13,  "symbol" : "€"}
}
```
# License
This code is distributed under the terms and conditions of the [GNU GPLv3](https://choosealicense.com/licenses/gpl-3.0/) license.

Copyright (c) 2017 Rafał Sroka
