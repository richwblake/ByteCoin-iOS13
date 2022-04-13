//
//  Conversion.swift
//  ByteCoin
//
//  Created by Wills Blake on 4/12/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct Conversion: Codable {
    let rate: Double
    let asset_id_quote: String
    
    internal func formattedRate() -> String {
        return String(format: "%.2f", rate)
    }
    
    internal func getCurrencyCode() -> String {
        return asset_id_quote
    }
}
