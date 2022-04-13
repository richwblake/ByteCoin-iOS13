//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CoinViewController: UIViewController {
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyCodeLabel: UILabel!
    
    var coinManager = CoinManager()
    
    func getCoinPrice(for currency: String) {
        coinManager.createRequest(for: currency)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
}

extension CoinViewController: CoinManagerDelegate {
    func didFinishFetching(_ conversion: Conversion) {
        DispatchQueue.main.async { [self] in
            currencyLabel.text = conversion.formattedRate()
            currencyCodeLabel.text = conversion.getCurrencyCode()
        }
    }
}

extension CoinViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

extension CoinViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currencyCode = coinManager.currencyArray[row]
        getCoinPrice(for: currencyCode)
    }
}
