//
//  functions.swift
//  Calculator Test
//
//  Created by Tomasz Kielar on 09/04/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class setups {
    let logo = UIImage(named: "logo")
    
    func setbuttons(numbers: [UIButton],functions: [UIButton]) {
        for every in numbers {
            every.titleLabel!.text = "\(every.tag-1)"
            every.backgroundColor = .darkGray
            every.titleLabel!.textColor = .white
            every.setTitleColor(.white, for: .normal)
            every.layer.cornerRadius = 15
        }
        for every in functions {
            switch every.tag {
            case 11...13:
                every.backgroundColor = .lightGray
                every.titleLabel!.textColor = .white
                every.setTitleColor(.white, for: .normal)
                every.layer.cornerRadius = 15
            case 14...18:
                every.backgroundColor = .orange
                every.setTitleColor(.white, for: .normal)
                every.titleLabel!.textColor = .white
                every.layer.cornerRadius = 15
            case 19:
                every.backgroundColor = .darkGray
                every.setTitleColor(.white, for: .normal)
                every.layer.cornerRadius = 15
            default:
                print("error in setting functional buttons")
            }
        }
    }
    
    func setLogo(view: UIViewController, button: UILabel) {
        let logoView = UIImageView(image: logo!)
        logoView.translatesAutoresizingMaskIntoConstraints = false // this shit is importand , dunno what it does actually
        view.view.addSubview(logoView)
        logoView.topAnchor.constraint(equalTo: view.view.safeAreaLayoutGuide.topAnchor).isActive = true
        logoView.leadingAnchor.constraint(equalTo: view.view.safeAreaLayoutGuide.leadingAnchor,constant: 20).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat,.autoreverse], animations: {
            logoView.transform = CGAffineTransform.identity.scaledBy(x: 1.25, y: 1.25)
   
            
        }, completion: { completion in
            logoView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        })
    }
    func setLabel(result:UILabel,resultNumber: Int) {
        result.text = "\(resultNumber)"
        result.textColor = .white
    }
}
class calculatorCore {
    var defaultValue: Int = 0
    var firstNumber:Decimal = 0
    var firstNumberHolder: Decimal = 0
    var secondNumber:Decimal = 0
    var secondNumberHolder: Decimal = 0
    var char:String = ""
    var previousChar :String = ""
    var previousValue = ""
    var output : Decimal = 0
    let charset : [String] = ["AC","+/-","%","/","X","-","+","Error","=",".",","]
    
    func numberPressed(sender: UIButton,result: UILabel) {
        previousValue = result.text!
        let pressedValue = sender.titleLabel?.text
        // result.text = NSString(format: "\(previ)%i", value!) as String
        if previousValue == String(0)||previousValue==String(0.0) || previousValue == "Error"  || previousValue == char || char == "=" {
            result.text = "\(pressedValue!)"
        }
        else {
            result.text = "\(previousValue+pressedValue!)"
        }
    }
    func functionKeysPressed(sender: UIButton,result:UILabel) {
        previousValue = result.text!
        if previousValue == "Error" {
            switch sender.tag {
            case 11:
                result.text = "\(defaultValue)"
                firstNumber = 0
                secondNumber = 0
                char = ""
            default:
                result.text = "Error"
                
            }
            
            
        }
        else {
            result.text = "\(previousValue)"
            switch sender.tag {
            case 11:
                result.text = "\(defaultValue)"
                firstNumber = 0
                secondNumber = 0
                char = ""
            case 12:
                print("change to minus")
                if charset.contains(result.text!)    {
                    print("xd")
                }
                else {
                    let previous = result.text!
                    if previous.first == "-" {
                        result.text! = String(previous.dropFirst())
                        print(result.text!)
                    }
                    else {
                        result.text = "-\(previous) "}}
            case 13:
                if charset.contains(result.text!)    {
                    char = sender.titleLabel!.text!
                    result.text = char
                }
                else {
                    secondNumber = Decimal(string:result.text!)!
                    switch char {
                    case "/":
                        output = firstNumber / (secondNumber * 0.01)
                        result.text = "\(output)"
                    case "X":
                        output = firstNumber * (secondNumber * 0.01)
                        result.text = "\(output)"
                    case "-":
                        output = firstNumber - (secondNumber * 0.01)*firstNumber
                        result.text = "\(output)"
                    case "+":
                        output = firstNumber + (secondNumber * 0.01)*firstNumber
                        result.text = "\(output)"
                    default:
                        result.text = "Error"
                    }
                }
            case 14...17:
                if charset.contains(result.text!)    {
                    char = sender.titleLabel!.text!
                    result.text = char
                }
                else {
                    firstNumber = Decimal(string: result.text!)!
                    print("liczba1: \(firstNumber)")
                char = sender.titleLabel!.text!
                    print(char)
                result.text = char }
            case 19:
                if charset.contains(result.text!)    {
                    char = sender.titleLabel!.text!
                    result.text = char
                }
                else if result.text?.last == "." {
                    result.text = previousValue
                }
                else {
                    
                    result.text = "\(previousValue)." }
                
            case 18:
                if charset.contains(result.text!) {
                    char = sender.titleLabel!.text!
                    result.text = char
                }
                else
                {
                    secondNumber = Decimal(string:result.text!)!
                    print("liczba2: \(secondNumber)")
                switch char {
                case "%":
                    print("XD")
                case "/":
                    output = firstNumber/secondNumber
                    firstNumberHolder = firstNumber
                    secondNumberHolder = secondNumber
                    result.text = "\(output)"
                    firstNumberHolder = output
                    previousChar = char
                    char = "="
                case "X":
                    output = firstNumber*secondNumber
                    firstNumberHolder = firstNumber
                    secondNumberHolder = secondNumber
                    result.text = "\(output)"
                    firstNumberHolder = output
                    previousChar = char
                    char = "="
                case "-":
                    output = firstNumber-secondNumber
                    firstNumberHolder = firstNumber
                    secondNumberHolder = secondNumber
                    result.text = "\(output)"
                    firstNumberHolder = output
                    previousChar = char
                    char = "="
                case "+":
                    output = firstNumber+secondNumber
                    firstNumberHolder = firstNumber
                    secondNumberHolder = secondNumber
                    result.text = "\(output)"
                    firstNumberHolder = output
                    previousChar = char
                    char = "="
                case "=":
                    switch previousChar {
                    case "%": print("xd")
                    case "/":
                    output = firstNumberHolder/secondNumberHolder
                    result.text = "\(output)"
                        firstNumberHolder = output
                    case "X":
                    output = firstNumberHolder*secondNumberHolder
                    result.text = "\(output)"
                        firstNumberHolder = output
                    case "-":
                    output = firstNumberHolder-secondNumberHolder
                    result.text = "\(output)"
                    firstNumberHolder = output
                    case "+":
                    output = firstNumberHolder+secondNumberHolder
                    result.text = "\(output)"
                        firstNumberHolder = output
                    default:
                        print("Error")
                    } // end of = switch
                    
                default:
                    result.text = "Error"
                    }} // end of char 
            
            default:
                print("Error")
                
            }
        }
        
        
        
        print("wynik: \(output)")
        
    }
    func dropsonLast(result:UILabel) {
        result.text = String((result.text?.dropLast())!)
    }

    }

