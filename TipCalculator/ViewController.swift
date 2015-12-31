//
//  ViewController.swift
//  TipCalculator
//
//  Created by Sagar Ali 12/26/15.
//  Copyright © 2015 Sagar Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipSegment: UISegmentedControl!
   
    
    @IBOutlet weak var tipText: UILabel!
    @IBOutlet weak var billText: UILabel!
    @IBOutlet weak var totalText: UILabel!
    @IBOutlet weak var dollarSignText: UILabel!
   
    
    @IBOutlet weak var peopleLabel: UILabel!
    
    var counter = 1     //global variable used to keep track of the number of emojis which represent the number of people the total bill is being split with
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        billField.becomeFirstResponder()        // keyboard is always available to the user
        totalLabel.userInteractionEnabled = true
        self.title =  "Tip Calculator"
       
        let tipSeg = NSUserDefaults.standardUserDefaults()
        
        if tipSeg.boolForKey("current")     //determines whether to use the default tip percentage or the most recently used when opening application
        {
            
            let currentTip = NSUserDefaults.standardUserDefaults()
           let tipIndex = currentTip.integerForKey("currentTipSeg")
            tipSegment.selectedSegmentIndex = tipIndex
        }
        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBillChanged(sender: AnyObject) {
        
        let currentTipSeg = NSUserDefaults.standardUserDefaults()       // saves the tip segment that the user currently has selected
        currentTipSeg.setInteger(tipSegment.selectedSegmentIndex, forKey: "currentTipSeg")
        
         let themeColor = NSUserDefaults.standardUserDefaults()
        
        if billField.text == ""{
            
            billField.center = CGPoint(x: 160, y:320)
            
           //dollarSignText.center = CGPoint(x: 139, y: 320)
            
            self.tipLabel.alpha = 0
            self.tipText.alpha = 0
            self.totalText.alpha = 0
            self.totalLabel.alpha = 0
            self.tipSegment.alpha = 0
            self.peopleLabel.alpha = 0
            
            if themeColor.boolForKey("colorTheme")  //determines which theme to adjust to
            {
              self.view.backgroundColor = UIColor.cyanColor()
               
            }
            else
            {
                 self.view.backgroundColor = UIColor.blackColor()
             
            }
            
            counter = 1
            peopleLabel.text = "😎"
            let smiles = NSUserDefaults.standardUserDefaults()
            smiles.setObject(peopleLabel.text, forKey: "smiles")
            
            let count = NSUserDefaults.standardUserDefaults()
            count.setInteger(counter, forKey:"counter")

            }
        else
        {
            billField.center = CGPoint(x: 160, y:120)
            
            //dollarSignText.center = CGPoint(x: 139, y: 120)
            UIView.animateWithDuration(0.5, animations:{
                self.tipLabel.alpha = 1
                self.tipText.alpha = 1
                self.totalText.alpha = 1
                self.totalLabel.alpha = 1
                self.tipSegment.alpha = 1
                self.peopleLabel.alpha = 1
                
            })
            
            
            if themeColor.boolForKey("colorTheme")
            {
                view.backgroundColor = UIColor.whiteColor()
                
            }
            else
            {
                view.backgroundColor = UIColor.purpleColor()
               
            }

        }
        
        let Percentages = NSUserDefaults.standardUserDefaults()
        var percentages = Percentages.objectForKey("new_Percentages")as? [Double] ?? [Double]()
        //var percentages = [0.1, 0.15, 0.2]
        let tipPercentage = percentages[tipSegment.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue  //calculating tip/total
        let tip = billAmount * tipPercentage
       let total = (billAmount+tip)/Double(counter)
        
    
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        
        let billFieldText = NSUserDefaults.standardUserDefaults()
        billFieldText.setObject(billField.text, forKey: "billField")
        
        }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    //--------------------------------------------------------
        // Loading up all of the values
        
        let billFieldText = NSUserDefaults.standardUserDefaults()
        billField.text = billFieldText.objectForKey("billField") as? String
        
        let smiles = NSUserDefaults.standardUserDefaults()
        peopleLabel.text = smiles.objectForKey("smiles") as? String
        
        let count = NSUserDefaults.standardUserDefaults()
        counter = count.integerForKey("counter")
      
        
        let tipSeg = NSUserDefaults.standardUserDefaults()
        
        if !(tipSeg.boolForKey("current"))
        {
        let defaultTip = NSUserDefaults.standardUserDefaults()
         let tipIndex = defaultTip.integerForKey("default_tip_index")
        tipSegment.selectedSegmentIndex = tipIndex
        }
        
        tipSeg.setBool(false, forKey: "current")
       
       
        let Percentages = NSUserDefaults.standardUserDefaults()
        var percentages = Percentages.objectForKey("new_Percentages")as? [Double] ?? [Double]()
        let tipPercentage = percentages[tipSegment.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount+tip
        
        //----------------------------------------------------------
        
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
         tipSegment.setTitle("\(Int(percentages[0]*100))%", forSegmentAtIndex: 0)   //changing the tip segement to match whats on the settings page
        tipSegment.setTitle("\(Int(percentages[1]*100))%", forSegmentAtIndex: 1)
        tipSegment.setTitle("\(Int(percentages[2]*100))%", forSegmentAtIndex: 2)
        
         let themeColor = NSUserDefaults.standardUserDefaults()
        
        if themeColor.boolForKey("colorTheme")
        {
            if(billField.text == "")
            {
            view.backgroundColor = UIColor.cyanColor()
                
                self.tipLabel.alpha = 0
                self.tipText.alpha = 0
                self.totalText.alpha = 0
                self.totalLabel.alpha = 0
                self.tipSegment.alpha = 0
                self.peopleLabel.alpha = 0
                billField.center = CGPoint(x: 160, y:320)
                counter = 1
                peopleLabel.text = "😎"
                let smiles = NSUserDefaults.standardUserDefaults()
                smiles.setObject(peopleLabel.text, forKey: "smiles")
                
                let count = NSUserDefaults.standardUserDefaults()
                count.setInteger(counter, forKey:"counter")
                
            }
            else
            {
                view.backgroundColor = UIColor.whiteColor()
                
                self.tipLabel.alpha = 1
                self.tipText.alpha = 1
                self.totalText.alpha = 1
                self.totalLabel.alpha = 1
                self.tipSegment.alpha = 1
                self.peopleLabel.alpha = 1
                 billField.center = CGPoint(x: 160, y:120)
            }
            totalLabel.textColor = UIColor.blackColor()
            tipLabel.textColor = UIColor.blackColor()
            tipText.textColor = UIColor.blackColor()
            totalText.textColor = UIColor.blackColor()
            billField.backgroundColor = UIColor.cyanColor()
            billField.textColor = UIColor.blackColor()
            tipSegment.tintColor = view.tintColor
            billField.attributedPlaceholder = NSAttributedString(string: "$",attributes: [NSForegroundColorAttributeName:UIColor.blackColor()])
            
        }
        else
        {
            
            if(billField.text == "")
            {
                view.backgroundColor = UIColor.blackColor()
                self.tipLabel.alpha = 0
                self.tipText.alpha = 0
                self.totalText.alpha = 0
                self.totalLabel.alpha = 0
                self.tipSegment.alpha = 0
                self.peopleLabel.alpha = 0
                 billField.center = CGPoint(x: 160, y:320)
                counter = 1
                peopleLabel.text = "😎"
                let smiles = NSUserDefaults.standardUserDefaults()
                smiles.setObject(peopleLabel.text, forKey: "smiles")
                
                let count = NSUserDefaults.standardUserDefaults()
                count.setInteger(counter, forKey:"counter")
            }
            else
            {
                view.backgroundColor = UIColor.purpleColor()
                self.tipLabel.alpha = 1
                self.tipText.alpha = 1
                self.totalText.alpha = 1
                self.totalLabel.alpha = 1
                self.tipSegment.alpha = 1
                self.peopleLabel.alpha = 1
                 billField.center = CGPoint(x: 160, y:120)
              }
            totalLabel.textColor = UIColor.whiteColor()
            tipLabel.textColor = UIColor.whiteColor()
            tipText.textColor = UIColor.whiteColor()
            totalText.textColor = UIColor.whiteColor()
            billField.backgroundColor = UIColor.blackColor()
            billField.textColor = UIColor.whiteColor()
            tipSegment.tintColor = UIColor.whiteColor()
            billField.attributedPlaceholder = NSAttributedString(string: "$",attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        }

        
    }
    
    
    
    @IBAction func splitBillSwipe(sender: AnyObject) {
       
        if counter < 5  //limits the bill to be only split by a max of 5 people
        {
            counter++
            let Percentages = NSUserDefaults.standardUserDefaults()
            var percentages = Percentages.objectForKey("new_Percentages")as? [Double] ?? [Double]()
            //var percentages = [0.1, 0.15, 0.2]
            let tipPercentage = percentages[tipSegment.selectedSegmentIndex]
            let billAmount = NSString(string: billField.text!).doubleValue
            let tip = billAmount * tipPercentage
            let total = (billAmount+tip)/Double(counter)

             totalLabel.text = "$\(total)"
            totalLabel.text = String(format: "$%.2f", total)
            peopleLabel.text = peopleLabel.text! + "😎"
            
            let smiles = NSUserDefaults.standardUserDefaults()
            smiles.setObject(peopleLabel.text, forKey: "smiles")
            
            let count = NSUserDefaults.standardUserDefaults()
            count.setInteger(counter, forKey:"counter")
        }
        
    }

    @IBAction func spiltBillSwipeR(sender: AnyObject) {
        
        if counter > 1 //min number of people the bill can be split with is 1
        {
            counter--
            let Percentages = NSUserDefaults.standardUserDefaults()
            var percentages = Percentages.objectForKey("new_Percentages")as? [Double] ?? [Double]()
           // var percentages = [0.1, 0.15, 0.2]
            let tipPercentage = percentages[tipSegment.selectedSegmentIndex]
            let billAmount = NSString(string: billField.text!).doubleValue
            let tip = billAmount * tipPercentage
            let total = (billAmount+tip)/Double(counter)

            
            totalLabel.text = "$\(total)"
            totalLabel.text = String(format: "$%.2f", total)
            
            peopleLabel.text = ""
            
            for var i = 0; i < counter; i++
            {
                peopleLabel.text = peopleLabel.text! + "😎"
            }
            
            let smiles = NSUserDefaults.standardUserDefaults()
            smiles.setObject(peopleLabel.text, forKey: "smiles")
            
            let count = NSUserDefaults.standardUserDefaults()
            count.setInteger(counter, forKey:"counter")
            
        }
        
    }

    
}

