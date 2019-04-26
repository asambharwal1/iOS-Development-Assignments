//
//  DVRViewController.swift
//  SambharwalA_TVRemote
//
//  Created by Aashish Sambharwal on 2/20/18.
//  Copyright © 2018 Aashish Sambharwal. All rights reserved.
//

import UIKit

var state:String = "Stop"
var stateOn = true

class DVRViewController: UIViewController {
    
    @IBOutlet weak var powerSwitch: UISwitch!
    @IBOutlet var disableButtons: [UIButton]!
    @IBOutlet weak var dvrPowerState: UILabel!
    @IBOutlet weak var deviceState: UILabel!
    
    @IBAction func switchBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    var forceState:String="N/A"
    let pairs:[String:[String]] =
        ["Play":["Record"],
         "Stop":[],
         "Pause":["Stop", "Fast Forward", "Fast Rewind", "Record"],
         "Fast Forward":["Stop", "Fast Rewind", "Pause", "Record"],
         "Fast Rewind":["Stop", "Fast Forward", "Pause", "Record"],
         "Record":["Play", "Pause", "Fast Forward", "Fast Rewind"]]
    
    @IBAction func optionsSelected(_ sender: UIButton) {
        let action = sender.titleLabel?.text ?? ""
        let didFinish = checkState(wrongStates: pairs[action] ?? [""], action: action)
        if didFinish {
            state = action
        }
        deviceState.text = "\(changeTense())"
        deviceState.adjustsFontSizeToFitWidth = true
    }
    
    func changeTense() -> String{
        var toDisplay = state
        if(state == "Play" || state == "Fast Forward" || state == "Fast Rewind" || state == "Record") {
            toDisplay = state + "ing"
        } else if state == "Stop" {
            toDisplay = state + "ped"
        } else {
            toDisplay = state + "d"
        }
        return toDisplay
    }
    
    func checkState(wrongStates:[String], action: String) -> Bool {
        for wstate in wrongStates {
            if wstate == state {
                createAlert(messageAlert: "Unsafe transition from \(state) to \(action). Continue anyway?", titleAlert: "Illegal Action")
                forceState = action
                return false
            }
        }
        return true
    }
    
    func forceChange(action: UIAlertAction!) {
        state = forceState
        deviceState.text = changeTense()
    }
    
    func forceStop() {
        deviceState.text = "Stopped"
    }

    func createAlert(messageAlert: String, titleAlert: String) {
        let alertCont = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let forceAction = UIAlertAction(title: "Continue", style: .destructive) { action in
            let alertCont = UIAlertController(title: "Change Initiated", message: "Changing from \(state) to \(self.forceState).", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: self.forceChange)
            alertCont.addAction(cancelAction)
            self.present(alertCont, animated: true, completion: self.forceStop)
        }
        alertCont.addAction(cancelAction)
        alertCont.addAction(forceAction)
        self.present(alertCont, animated: true, completion: nil)
    }
    
    @IBAction func powerChange(_ sender: UISwitch) {
        /*dvrPowerState.text = sender.isOn ? "On" : "Off"
        for button in disableButtons {
            button.isEnabled = sender.isOn
        }*/
        changePowerState(isON: sender.isOn)
    }
    
    func changePowerState (isON : Bool) {
        dvrPowerState.text = isON ? "On" : "Off"
        for button in disableButtons {
            button.isEnabled = isON
        }
        stateOn = isON
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        deviceState.text = "\(changeTense())"
        changePowerState(isON: stateOn)
        powerSwitch.isOn = stateOn
        deviceState.adjustsFontSizeToFitWidth = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
