//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Sagar Ali on 12/26/15.
//  Copyright © 2015 Sagar Ali. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipSegment: UISegmentedControl!
    
    @IBOutlet weak var tipSlider: UISlider!
    
    @IBOutlet weak var darkThemeButton: UIButton!
    
    @IBOutlet weak var lightThemeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let defaultTip = NSUserDefaults.standardUserDefaults()
        let tipIndex = defaultTip.integerForKey("default_tip_index")
        defaultTipSegment.selectedSegmentIndex = tipIndex
        
        let tipString = defaultTipSegment.titleForSegmentAtIndex(defaultTipSegment.selectedSegmentIndex)
        
        tipSlider.value = NSString(string: tipString!).floatValue
        
         let themeColor = NSUserDefaults.standardUserDefaults()
        if themeColor.boolForKey("colorTheme")
        {
            lightThemeButton.selected = true
        }
        else
        {
            darkThemeButton.selected = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func defaultTipSelected(sender: AnyObject) {
        
     
            
        let defaultTip = NSUserDefaults.standardUserDefaults()
        
        defaultTip.setInteger(defaultTipSegment.selectedSegmentIndex, forKey: "default_tip_index")
        
        defaultTip.synchronize()
            
   
        
        let tipString = defaultTipSegment.titleForSegmentAtIndex(defaultTipSegment.selectedSegmentIndex)
        
        tipSlider.value = NSString(string: tipString!).floatValue
        
    }
    
    

    @IBAction func percentChange(sender: AnyObject) {
        
        defaultTipSegment.setTitle("\(Int(round(tipSlider.value)))%", forSegmentAtIndex: defaultTipSegment.selectedSegmentIndex)
        
        var Percentages = NSUserDefaults.standardUserDefaults()
        var newPercentages = Percentages.objectForKey("new_Percentages")as? [Double] ?? [Double]()
        
        newPercentages[defaultTipSegment.selectedSegmentIndex] = Double(round(tipSlider.value))/100
        
         Percentages = NSUserDefaults.standardUserDefaults()
        
        Percentages.setObject(newPercentages, forKey: "new_Percentages")
        
        Percentages.synchronize()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let Percentages = NSUserDefaults.standardUserDefaults()
        let newPercentages = Percentages.objectForKey("new_Percentages")as? [Double] ?? [Double]()
        
         defaultTipSegment.setTitle("\(Int(newPercentages[0]*100))%", forSegmentAtIndex: 0)
        defaultTipSegment.setTitle("\(Int(newPercentages[1]*100))%", forSegmentAtIndex: 1)
        defaultTipSegment.setTitle("\(Int(newPercentages[2]*100))%", forSegmentAtIndex: 2)
        
        
        let tipString = defaultTipSegment.titleForSegmentAtIndex(defaultTipSegment.selectedSegmentIndex)
        
        tipSlider.value = NSString(string: tipString!).floatValue
        
    }
    
    @IBAction func resetPercentages(sender: AnyObject) {
        
        let newPercentages = [0.1, 0.15, 0.20]
        
        let Percentages = NSUserDefaults.standardUserDefaults()
        
        Percentages.setObject(newPercentages, forKey: "new_Percentages")
        
        Percentages.synchronize()
        
        viewWillAppear(true)
        
    }
    
    @IBAction func lightThemeSelected(sender: AnyObject) {
        
        lightThemeButton.selected = true
        darkThemeButton.selected = false
        let lightTheme = true
        
        let themeColor = NSUserDefaults.standardUserDefaults()
        themeColor.setBool(lightTheme, forKey: "colorTheme")
    }
    
    @IBAction func darkThemeSelected(sender: AnyObject) {
        
        lightThemeButton.selected = false
        darkThemeButton.selected = true
        let lightTheme = false
        
        let themeColor = NSUserDefaults.standardUserDefaults()
        themeColor.setBool(lightTheme, forKey: "colorTheme")
    }
}
