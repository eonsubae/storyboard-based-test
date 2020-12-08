//
//  ViewController.swift
//  Currency Converter
//
//  Created by ma-esb on 2020/12/08.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var convertedLabel: UILabel!
    @IBOutlet weak var rateTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var currencySegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func convertTapped(_ sender: Any) {
        let rate = Double(rateTextField.text!)!
        let amount = Double(amountTextField.text!)!
        
        let converted = rate * amount
        
        if currencySegmentControl.selectedSegmentIndex == 0 {
            convertedLabel.text = "$\(converted)"
        } else {
            convertedLabel.text = "￥\(converted)"
        }
    }
}
