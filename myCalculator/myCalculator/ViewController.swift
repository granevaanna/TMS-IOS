//
//  ViewController.swift
//  myCalculator
//
//  Created by Анна Гранёва on 15.10.21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button_0: UIButton!
    @IBOutlet weak var button_1: UIButton!
    @IBOutlet weak var button_2: UIButton!
    @IBOutlet weak var button_3: UIButton!
    @IBOutlet weak var button_4: UIButton!
    @IBOutlet weak var button_5: UIButton!
    @IBOutlet weak var button_6: UIButton!
    @IBOutlet weak var button_7: UIButton!
    @IBOutlet weak var button_8: UIButton!
    @IBOutlet weak var button_9: UIButton!
    
    
    @IBOutlet weak var buttonPoint: UIButton!
    
    @IBOutlet weak var buttonEquals: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonMultiply: UIButton!
    @IBOutlet weak var buttonDivide: UIButton!
    
    @IBOutlet weak var buttonPercent: UIButton!
    @IBOutlet weak var buttonPlusMinus: UIButton!
    @IBOutlet weak var buttonAC: UIButton!
    
    
    @IBOutlet weak var textField: UITextField!
    
    var flag: Bool = true
    var firstNumber: Double = 0
    var secondNumber: Double = 0
    var tag: String = ""
    var flagPoint: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionAndSizeOfAllButtons()
    }
    
    
    @IBAction func button0Action(_ sender: Any) {
        if flag {
        if textField.text != "0"{
            if let text = textField.text{
                textField.text = "\(text)\(0)"
            }
        }
        }else{
            textField.text = "\(0)"
        }
    }
    
    
    @IBAction func button1Action(_ sender: Any) {
        pressOnTheNumberButton(n: 1)
    }
    

    @IBAction func button2Action(_ sender: Any) {
        pressOnTheNumberButton(n: 2)
    }
    
    
    @IBAction func button3Action(_ sender: Any) {
        pressOnTheNumberButton(n: 3)
    }
    
    
    @IBAction func button4Action(_ sender: Any) {
        pressOnTheNumberButton(n: 4)
    }
    
    
    @IBAction func button5Action(_ sender: Any) {
        pressOnTheNumberButton(n: 5)
    }
    
    @IBAction func button6Action(_ sender: Any) {
        pressOnTheNumberButton(n: 6)
    }
    
    
    
    @IBAction func button7Action(_ sender: Any) {
        pressOnTheNumberButton(n: 7)
    }
    
    
    @IBAction func button8Action(_ sender: Any) {
        pressOnTheNumberButton(n: 8)
    }
    
    
    @IBAction func button9Action(_ sender: Any) {
        pressOnTheNumberButton(n: 9)
    }
    
    
    @IBAction func buttonPointAction(_ sender: Any) {
        if flag{
        if flagPoint{
            if let text = textField.text{
                textField.text = "\(text)."
            }
        }
        } else{
            textField.text = "0."
            flag = true
        }
        flagPoint = false
    }
    
    
    @IBAction func buttonEqualsAction(_ sender: Any) {
        if let text = textField.text, let value = Double(text){
            secondNumber = value
        }
        if tag == "+"{
            textField.text = "\(firstNumber + secondNumber)"
        } else if tag == "-"{
            textField.text = "\(firstNumber - secondNumber)"
        } else if tag == "*"{
            textField.text = "\(firstNumber * secondNumber)"
        } else if tag == "/"{
            if secondNumber != 0 {
                textField.text = "\(firstNumber / secondNumber)"
            }else{
                textField.text = "Undefined"
            }
        } else if tag == "%"{
            textField.text = "\(firstNumber.truncatingRemainder(dividingBy: secondNumber))"
        }
        
        firstNumber = 0
        secondNumber = 0
        flag = false
        tag = ""
    }
    
    
    @IBAction func buttonPlusAction(_ sender: Any) {
        pressOnTheOperationButton()
        flagPoint = true
        tag = "+"
    }
    
    
    @IBAction func buttonMinusAction(_ sender: Any) {
        pressOnTheOperationButton()
        tag = "-"
    }
    
    @IBAction func buttonMultiplyAction(_ sender: Any) {
        pressOnTheOperationButton()
        tag = "*"
    }
    
    @IBAction func buttonDivideAction(_ sender: Any) {
        pressOnTheOperationButton()
        tag = "/"
    }
    
    
    @IBAction func buttonACAction(_ sender: Any) {
        firstNumber = 0
        secondNumber = 0
        flag = true
        tag = ""
        flagPoint = true
        if textField.text != "0"{
            textField.text = "\(0)"
            buttonAC.setTitle("AC", for: .normal)
            buttonAC.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        }
        
    }
    
    
    @IBAction func buttonPlusMinusAction(_ sender: Any) {
        if let text = textField.text, let value = Double(text), value != 0 {
            textField.text = "\(-1 * value)"
        }
        
    }
    
    
    @IBAction func buttonPercentAction(_ sender: Any) {
        pressOnTheOperationButton()
        tag = "%"
    }
    
    
    func pressOnTheNumberButton(n:Int){
        buttonAC.setTitle("C", for: .normal)
        buttonAC.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        if flag {
        if textField.text == "0"{
            textField.text = "\(n)"
        } else if let text = textField.text{
            textField.text = "\(text)\(n)"
        }
        } else {
            textField.text = "\(n)"
            flag = true
        }
    }
    
    func pressOnTheOperationButton (){
        if let text = textField.text, let value = Double(text){
            if firstNumber == 0{
            firstNumber = value
            } else{
                if tag == "+"{
                    firstNumber += value
                } else if tag == "-"{
                    firstNumber -= value
                } else if tag == "*"{
                    firstNumber *= value
                } else if tag == "/"{
                    if value != 0{
                    firstNumber /= value
                    }else{
                        textField.text = "Undefined"
                    }
                } else if tag == "%"{
                    firstNumber = firstNumber.truncatingRemainder(dividingBy: value)
                }
            }
            flag = false
        }
    }
    func positionAndSizeOfAllButtons(){
        button_0.frame = CGRect(x: 0, y: view.frame.height - 0.13 * view.frame.height, width: 0.5 * view.frame.width, height: 0.13 * view.frame.height)
        buttonPoint.frame = CGRect(x: 2 * 0.25 * view.frame.width, y: view.frame.height - 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        buttonEquals.frame = CGRect(x: 3 * 0.25 * view.frame.width, y: view.frame.height - 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        button_1.frame = CGRect(x: 0, y: view.frame.height - 2 * 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        button_2.frame = CGRect(x: 0.25 * view.frame.width, y: view.frame.height - 2 * 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        button_3.frame = CGRect(x: 2 * 0.25 * view.frame.width, y: view.frame.height - 2 * 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        buttonPlus.frame = CGRect(x: 3 * 0.25 * view.frame.width, y: view.frame.height - 2 * 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        button_4.frame = CGRect(x: 0, y: view.frame.height - 3 * 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        button_5.frame = CGRect(x: 0.25 * view.frame.width, y: view.frame.height - 3 * 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        button_6.frame = CGRect(x: 2 * 0.25 * view.frame.width, y: view.frame.height - 3 * 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        buttonMinus.frame = CGRect(x: 3 * 0.25 * view.frame.width, y: view.frame.height - 3 * 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        button_7.frame = CGRect(x: 0, y: view.frame.height - 4 * 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        button_8.frame = CGRect(x: 0.25 * view.frame.width, y: view.frame.height - 4 * 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        button_9.frame = CGRect(x: 2 * 0.25 * view.frame.width, y: view.frame.height - 4 * 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        buttonMultiply.frame = CGRect(x: 3 * 0.25 * view.frame.width, y: view.frame.height - 4 * 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        buttonAC.frame = CGRect(x: 0, y: view.frame.height - 5 * 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        buttonPlusMinus.frame = CGRect(x: 0.25 * view.frame.width, y: view.frame.height - 5 * 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        buttonPercent.frame = CGRect(x: 2 * 0.25 * view.frame.width, y: view.frame.height - 5 * 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        buttonDivide.frame = CGRect(x: 3 * 0.25 * view.frame.width, y: view.frame.height - 5 * 0.13 * view.frame.height, width: 0.25 * view.frame.width, height: 0.13 * view.frame.height)
        
        textField.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 5 * 0.13 * view.frame.height)
        textField.isUserInteractionEnabled = false
        textField.text = "0"
    }
    
}

