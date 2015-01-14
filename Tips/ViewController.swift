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
    
    func zeroOutFields(){
        println("zeroing out")
        formatter.numberStyle = .CurrencyStyle
        if tipLabel != nil {
            tipLabel.text = formatter.stringFromNumber(0)
        }
        if totalLabel != nil {
            totalLabel.text = formatter.stringFromNumber(0)
        }
        if billField != nil {
            billField.text = ""
        }
    }
    
    override func viewWillAppear(animated:Bool){
        println("appearing")
    }
    
    override func viewDidLoad() {
        println("loading")
        super.viewDidLoad()
        defaults.synchronize()
        perPersonField.hidden = true
        perPersonLabel.hidden = true
        tipControl.selectedSegmentIndex = defaults.integerForKey("default_tip_index")
        if defaults.objectForKey("billTimestamp") != nil {
            var billAmount = defaults.doubleForKey("billAmount")
            println(billAmount)
            billField.text = NSString(format: "%.2f", billAmount)
            tipLabel.text = defaults.objectForKey("tipLabelText") as? String
            totalLabel.text = defaults.objectForKey("totalLabelText") as? String
        } else {
            zeroOutFields()
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "willEnterForeground:", name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    func willEnterForeground(notification: NSNotification!){
        println("willEnterForeground")
        // check if billAmount was entered in last 20 seconds
        var currentTime = NSDate()
        var lastChanged: NSDate!
        if defaults.objectForKey("billTimestamp") != nil {
            lastChanged = defaults.objectForKey("billTimestamp") as NSDate
            // time interval in seconds since bill Amount was entered
            let interval = currentTime.timeIntervalSinceDate(lastChanged)
            if interval > 20 {
                zeroOutFields()
            }
        }
        
    }
    
    deinit {
        // make sure to remove the observer when this view controller is dismissed/deallocated
        NSNotificationCenter.defaultCenter().removeObserver(self, name: nil, object: nil)
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

