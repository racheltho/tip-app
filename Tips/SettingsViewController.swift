//
//  SettingsViewController.swift
//  Tips
//
//  Created by Rachel Thomas on 1/12/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    var tipPercentageIndex:Int!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipControl.selectedSegmentIndex = defaults.integerForKey("default_tip_index")
    }

    @IBAction func onEditing(sender: AnyObject) {
        tipPercentageIndex = tipControl.selectedSegmentIndex
    }
    
    @IBAction func saveTipPercentage(sender: AnyObject) {
        tipPercentageIndex = tipControl.selectedSegmentIndex
        defaults.setInteger(tipPercentageIndex, forKey: "default_tip_index")
        defaults.synchronize()
        self.performSegueWithIdentifier("returnToCalculator", sender: self)
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        self.performSegueWithIdentifier("returnToCalculator", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
