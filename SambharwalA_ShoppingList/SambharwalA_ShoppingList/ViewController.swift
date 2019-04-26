//
//  ViewController.swift
//  SambharwalA_ShoppingList
//
//  Created by Aashish Sambharwal on 2/14/18.
//  Copyright © 2018 Aashish Sambharwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let defaultStateList:String = "No items"
    
    @IBOutlet weak var shoppingList: UITextView!
    @IBOutlet weak var itemDescription: UITextField!
    @IBOutlet weak var itemQuantity: UITextField!
    
    @IBOutlet var itemDetails: [UITextField]!
    
    @IBAction func backgroundTouched(_ sender: UIControl) {
        for field in itemDetails {
            field.resignFirstResponder()
        }
        sender.resignFirstResponder()
    }
    
    @IBAction func finishItemDesc(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    
    @IBAction func createNewList(_ sender: UIButton) {
        shoppingList.text = defaultStateList
    }
    
    @IBAction func createNewItem(_ sender: UIButton) {
        itemDescription.text = ""
        itemQuantity.text = ""
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        let description = itemDescription.text ?? ""
        let quantity = Int(itemQuantity.text ?? "") ?? 0
        
        if (quantity > 0 && description != "") {
            shoppingList.text = ((shoppingList.text ?? "") == defaultStateList) ? "" : shoppingList.text
  
            shoppingList.text.append(displayFood(item: description, qt: quantity))
            
        } else {
            let title = "Invalid Input"
            var message = ""
            if description == "" {
                message += "Invalid Description: None\n"
            }
            if quantity == 0 {
                message += "Invalid Quantity: 0\n"
            }
            message += "⚠️"
            let alertCont = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertCont.addAction(cancelAction)
            
            present(alertCont, animated: true, completion: nil)
        }
    }
    
    func displayFood(item: String, qt: Int) -> String {
        return "\(qt)x \(item)\n"
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

