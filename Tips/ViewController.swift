//
//  ViewController.swift
//  Tips
//
//  Created by Rachel Thomas on 1/2/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var splitBillControl: UISegmentedControl!
    @IBOutlet weak var perPersonLabel: UILabel!
    @IBOutlet weak var perPersonField: UILabel!
    let defaults = NSUserDefaults.standardUserDefaults()
    let formatter = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.synchronize()
        perPersonField.hidden = true
        perPersonLabel.hidden = true
        tipControl.selectedSegmentIndex = defaults.integerForKey("default_tip_index")
        formatter.numberStyle = .CurrencyStyle

        // check if billAmount was entered in last 30 seconds
        var currentTime = NSDate()
        var lastChanged: NSDate!
        if defaults.objectForKey("billTimestamp") != nil {
            
            lastChanged = defaults.objectForKey("billTimestamp") as NSDate
            println(lastChanged)
            // time interval in seconds since bill Amount was entered
            let interval = currentTime.timeIntervalSinceDate(lastChanged)
            if interval < 60 * 0.25 {
                var billAmount = defaults.doubleForKey("billAmount")
                println(billAmount)
                billField.text = NSString(format: "%.2f", billAmount)
                tipLabel.text = defaults.objectForKey("tipLabelText") as? String
                totalLabel.text = defaults.objectForKey("totalLabelText") as? String
            } else {
                tipLabel.text = formatter.stringFromNumber(0)
                totalLabel.text = formatter.stringFromNumber(0)
            }
            
        }
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var splitBillNums = [1, 2, 3, 4]
        var splitBillNum = splitBillNums[splitBillControl.selectedSegmentIndex]
        
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        var perPersonAmount = total / splitBillNum._bridgeToObjectiveC().doubleValue
        
        formatter.numberStyle = .CurrencyStyle
        tipLabel.text = formatter.stringFromNumber(tip)
        totalLabel.text = formatter.stringFromNumber(total)
        
        // save most recent time fields were edited, as well as values
        // this will be checked on viewDidLoad, and most recent values will be loaded if less 
        // than a certain amount of time has elapsed.
        var timeChanged = NSDate()
        defaults.setObject(timeChanged, forKey: "billTimestamp")
        defaults.setDouble(billAmount, forKey: "billAmount")
        defaults.setObject(tipLabel.text, forKey: "tipLabelText")
        defaults.setObject(totalLabel.text, forKey: "totalLabelText")
        defaults.synchronize()
        
        if(splitBillNum > 1){
            perPersonField.hidden = false
            perPersonLabel.hidden = false
            perPersonField.text = formatter.stringFromNumber(perPersonAmount)
        }else{
            perPersonField.hidden = true
            perPersonLabel.hidden = true
        }
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
}

