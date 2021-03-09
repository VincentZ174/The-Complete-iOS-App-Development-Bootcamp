//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet var billTextField: UITextField!
    @IBOutlet var zeroPCTButton: UIButton!
    @IBOutlet var tenPCTButton: UIButton!
    @IBOutlet var twentyPCTButton: UIButton!
    @IBOutlet var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var finalResult = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        zeroPCTButton.isSelected = false
        tenPCTButton.isSelected = false
        twentyPCTButton.isSelected = false
        
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        
        let buttonTitleAsNumber = Double(buttonTitleMinusPercentSign)!
        
        tip = buttonTitleAsNumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = Int(sender.value).description
        numberOfPeople = Int(sender.value)
    }

    @IBAction func calculatePressed(_ sender: UIButton) {
        let amountLabel = billTextField.text!
        if amountLabel != "" {
            let amount = Double(amountLabel)!
            let totalPerPerson = amount * (1+tip) / Double(numberOfPeople)
            print(totalPerPerson)
            finalResult = String(format: "%.2f", totalPerPerson)
            print(finalResult)
        }
        
        self.performSegue(withIdentifier: "goToResults", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ResultsViewController
        
        destinationVC.totalPerPerson = finalResult
        destinationVC.tip = Int(tip * 100)
        destinationVC.split = numberOfPeople
    }
    
}

