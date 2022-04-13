//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didFinishFetching(_ conversion: Conversion)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "C6F79A24-02D6-4AD1-BA5A-CB16D0F9DBC5"
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    internal func createRequest(for currency: String) {
        let fullURL = baseURL + "/" + currency + "?apikey=" + apiKey
        makeGetRequestForConversion(urlString: fullURL)
        
    }
    
    private func makeGetRequestForConversion(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let conversion = parseJSON(for: safeData) {
                        delegate?.didFinishFetching(conversion)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(for json: Data) -> Conversion? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Conversion.self, from: json)
            return Conversion(rate: decodedData.rate, asset_id_quote: decodedData.asset_id_quote)
        } catch {
            print(error)
            return nil
        }
        
//        do {
//            let weatherDecoded = try decoder.decode(WeatherData.self, from: data)
//            let weather = Weather(cityName: weatherDecoded.name, temperature: weatherDecoded.main.temp, conditionId: weatherDecoded.weather[0].id, sunrise: Date(timeIntervalSince1970: weatherDecoded.sys.sunrise), sunset: Date(timeIntervalSince1970: weatherDecoded.sys.sunset))
//
//            return weather
//        } catch {
//            print("error!")
//            return nil
//        }
    }
}
