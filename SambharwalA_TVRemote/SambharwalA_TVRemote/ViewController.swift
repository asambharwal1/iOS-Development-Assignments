//
//  ViewController.swift
//  SambharwalA_TVRemote
//
//  Created by Aashish Sambharwal on 2/10/18.
//  Copyright © 2018 Aashish Sambharwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Favorite Channel's UISegementedControl for instant changing of channel.
    @IBOutlet weak var favChannel: UISegmentedControl!
    
    //The controls view.
    @IBOutlet weak var controls: UIView!
    
    //Adjusts and displays the current volume label according to the slider
    @IBOutlet weak var volumeLevel: UILabel!
    
    //Changes the volume display according to the slider.
    @IBAction func volumeChanger(_ sender: UISlider) {
        volumeLevel.text = "\(Int(sender.value*100))"
    }
    //Declares to the users whether the power is On or Off
    @IBOutlet weak var tvPower: UILabel!
    
    //Adjusts the control availablity according to the switch's on or off state.
    @IBAction func power(_ sender: UISwitch) {
        tvPower.text = (sender.isOn) ? "On" : "Off"
        //Uses tags instead of IBOutlets, 1-12 are buttons, 13 is UISegmentedControl and 14 is UISlider
        for number in 1...14 {
            if number <= 12 {
                let button = self.view.viewWithTag(number) as! UIButton
                button.isEnabled = sender.isOn
            } else if number == 13 {
                let segements = self.view.viewWithTag(number) as! UISegmentedControl
                segements.isEnabled = sender.isOn
            } else if number == 14 {
                let slider = self.view.viewWithTag(number) as! UISlider
                slider.isEnabled = sender.isOn
            }
        }
        let numberFix = Int(channelNumber.text!) ?? previousChannel
        generatedChannel = ""
        channelNumber.text = "\(numberFix)"
    }
    
    //Keeps track of the previous channel in-case the user steps up in-between a switch.
    var previousChannel:Int  = 1
    
    //The channel number that is shown on the app.
    @IBOutlet weak var channelNumber: UILabel!
    
    //Changes the label of the channel number to the designated favorite's number.
    @IBAction func favoriteChannelSelected(_ sender: UISegmentedControl) {
        channelNumber.text = "\(favChannel.selectedSegmentIndex+1)"
    }
    
    //Channel generated via input handling
    var generatedChannel:String = ""
    
    //Handles the input via numberpad on the application.
    @IBAction func numberInputHandler(_ sender: UIButton) {
        if let chButton = sender.titleLabel {
            let numberToAdd = chButton.text ?? ""
            generatedChannel.append(numberToAdd)
            if(generatedChannel.count==2){
                let value = Int(generatedChannel) ?? 01
                
                //Doesn't allow for 0 values.
                channelNumber.text = "\((value != 0) ? value : 1)"
                
                //Resets the channel that was generated
                generatedChannel = ""
                correctIfFavorite(channel: (value != 0) ? value : 1)
            } else {
                //If first digit add to the generated channel variable.
                
                previousChannel = Int(channelNumber.text!)!
                channelNumber.text = generatedChannel + "_"
            }
        }
    }
    
    //Handles only the channel increment and decrement.
    @IBAction func channelStepper(_ sender: UIButton) {
        if let stepperButton = sender.titleLabel {
            let incDec = stepperButton.text ?? ""
            let toIncrement = Int(channelNumber.text!) ?? previousChannel
            if incDec == "Ch +" && toIncrement < 99{
                channelNumber.text = "\(toIncrement+1)"
                generatedChannel = ""
                correctIfFavorite(channel: toIncrement+1)
            } else if incDec == "Ch -" && toIncrement > 1 {
                channelNumber.text = "\(toIncrement-1)"
                generatedChannel = ""
                correctIfFavorite(channel: toIncrement-1)
            }
        }
    }
    
    //Corrects the favorite channel button to accomodate for favorite channel selection
    func correctIfFavorite(channel: Int){
        if channel <= 4 {
            favChannel.selectedSegmentIndex = channel-1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

