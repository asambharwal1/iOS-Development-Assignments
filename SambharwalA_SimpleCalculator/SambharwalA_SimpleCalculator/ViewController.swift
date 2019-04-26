//
//  ViewController.swift
//  SambharwalA_SimpleCalculator
//
//  Created by Aashish Sambharwal on 1/26/18.
//  Copyright © 2018 Aashish Sambharwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Keeping track of last input character either operator or number
    var lastExpressionCall:String = ""

    //Output & Input Screen
    @IBOutlet weak var outputExpression: UILabel!
    
    //Action for Buttons
    @IBAction func inputExpression(_ sender: UIButton) {
        //Unwraps the optional
        if let expression = (sender.titleLabel?.text) {
            
            if expression == "+" || expression == "-" {
                //Add + or - operators and checks if the last expression wasn't an operator or is empty
                if lastExpressionCall != "+" && lastExpressionCall != "-" {
                    outputExpression.text?.append(" \(expression) ")
                    lastExpressionCall = "\(expression)"
                }
                
            } else if expression == "=" {
                //To calculate the expression
                if lastExpressionCall != "-" && lastExpressionCall != "+" {
                    lastExpressionCall = "="
                    let result = calculateExpression()
                    outputExpression.text = "\(result)"
                }
                
            } else if expression == "CE" {
                //Clear Equation: To clear the screen of input/output by setting the value to 0.
                outputExpression.text = "0"
                lastExpressionCall = ""
                
            } else if expression == "DEL" {
                /* DEL: Acts as a deleter of the last character and replaces the last expression
                   variable. If everything is deleted, it reverts it to a 0 to avoid any errors.
                */
                
                //Deletes the last element if it is an operator
                if lastExpressionCall == "+" || lastExpressionCall == "-" {
                    
                    if let equation = outputExpression.text {
                        //Handling deletion of the negative integer
                        if equation.count == 1 && equation == "-" {
                            outputExpression.text = "0"
                        } else {
                            //Deleting an actual operator
                            let indexOfOperator = equation.index(equation.endIndex, offsetBy: -3)
                            outputExpression.text = String(equation[equation.startIndex..<indexOfOperator])
                        }
                    }
                } else {
                    //Handles number deletion
                    if let outEx = outputExpression?.text {
                        if outEx != "0" {
                            if outEx.count == 1 {
                                outputExpression?.text = "0"
                            } else {
                                outputExpression?.text!.removeLast()
                            }
                        }
                    }
                }
                
                //Handles the changing of the last expression variable
                if let lastCharacter = outputExpression?.text?.last {
                    if let equation = outputExpression.text {
                        //Since operators can only allow spaces at the end: " + " or " - "
                        if lastCharacter == " " {
                            //Index excluding the first white space: "+ " or "- "
                            let indexOfOperator = equation.index(equation.endIndex, offsetBy: -2)
                            lastExpressionCall = String(equation[indexOfOperator..<equation.endIndex])
                            //Removes the last whitespace "+" or "-"
                            lastExpressionCall.removeLast()
                        } else {
                            if let lastcharInEq = equation.last {
                                if(equation != "0"){
                                    lastExpressionCall = "\(lastcharInEq)"
                                } else {
                                    lastExpressionCall = ""
                                }
                            }
                        }
                    }
                }
            } else {
                //Handles Numbers by adding them to the outputExpression string
                
                //Removes the zero if a digit is pressed
                if(outputExpression.text! == "0" && expression != "0"){
                    outputExpression.text = ""
                }
                
                if expression == "0" {
                    if lastExpressionCall != "+" && lastExpressionCall != "-" && lastExpressionCall != "" && outputExpression?.text != "0" {
                        outputExpression.text?.append(expression)
                        lastExpressionCall = expression
                    }
                } else {
                    outputExpression.text?.append(expression)
                    lastExpressionCall = expression
                }
            }
        }
    }
    
    //Function to calculate the expression given on the screen
    func calculateExpression() -> Int {
        var finalResult:Int = 0
        if let out = outputExpression.text {
            //Creating an array for simple differentiating of integers and operators
            let arr = out.components(separatedBy: " ")
            var negativity = 1
            for i in 0..<arr.count {
                //Handles negative and positive entries
                if(arr[i] == "-"){
                    negativity = -1
                } else  if (arr[i] == "+"){
                    negativity = 1
                }
                //Converts and adds or subtracts the integer
                if arr[i] != "+" && arr[i] != "-" {
                    if let val = Int(arr[i]) {
                        finalResult += negativity * val
                    }
                }
            }
        }
        return finalResult
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

