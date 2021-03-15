//
//  ViewController.swift
//  Calc
//
//  Created by Илья Виноградов on 06.02.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var global: UIView!
    lazy var widthView: CGFloat = global.frame.width
    lazy var buttonSize = widthView / 5
    lazy var hightView = buttonSize * 6 + 1/5 * buttonSize
    lazy var spacerButton = buttonSize / 5
    var elementsNumpad = ["C","+/-","%","/",
                          "7","8","9","X",
                          "4","5","6","-",
                          "1","2","3","+",
                          "0",",","="]
    var incElem = 0
    var firstNum: Float?
    var operation: String = ""
    var resLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "0"
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 100)
        return label
    }()
    
    var viewNum: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    func numPud(){
        
        for y in 0...3{
            for x in 0...3{
                let buttonF: UIButton = UIButton(type: .custom)
                buttonF.frame = CGRect(x: spacerButton*CGFloat(x+1)+(CGFloat(x)*buttonSize), y: spacerButton*CGFloat(y+1)+(CGFloat(y)*buttonSize), width: buttonSize, height: buttonSize)
                buttonF.layer.cornerRadius = buttonF.bounds.size.width / 2
                buttonF.clipsToBounds = true
                buttonF.setTitleColor(.black, for: .normal)
                buttonF.setTitle(elementsNumpad[incElem], for: .normal)
                buttonF.backgroundColor = .white
                buttonF.tag = incElem
                viewNum.addSubview(buttonF)
                
                if Int(elementsNumpad[buttonF.tag]) != nil{
                    buttonF.addTarget(self, action: #selector(numberPress), for: .touchUpInside)
                } else {
                    buttonF.addTarget(self, action: #selector(operationPress(_:)), for: .touchUpInside)
                }
                incElem+=1
            }
        }
        
        let buttonZero: UIButton = UIButton(type: .custom)
        buttonZero.frame = CGRect(x: spacerButton, y: spacerButton * 5 + buttonSize * 4, width: 2*buttonSize + spacerButton, height: buttonSize)
        buttonZero.layer.cornerRadius = 41
        buttonZero.clipsToBounds = true
        buttonZero.backgroundColor = .white
        buttonZero.setTitleColor(.black, for: .normal)
        buttonZero.setTitle(elementsNumpad[incElem], for: .normal)
        buttonZero.tag = incElem
        viewNum.addSubview(buttonZero)
        buttonZero.addTarget(self, action: #selector(numberPress), for: .touchUpInside)
        incElem+=1
        
        for x in 0...1{
            let buttonF: UIButton = UIButton(type: .custom)
            buttonF.frame = CGRect(x: spacerButton*CGFloat(x+3)+(CGFloat(x+2)*buttonSize), y: spacerButton * 5 + buttonSize * 4, width: buttonSize, height: buttonSize)
            buttonF.layer.cornerRadius = buttonF.bounds.size.width / 2
            buttonF.clipsToBounds = true
            buttonF.backgroundColor = .white
            buttonF.setTitleColor(.black, for: .normal)
            buttonF.setTitle(elementsNumpad[incElem], for: .normal)
            buttonF.tag = incElem
            viewNum.addSubview(buttonF)
            if Int(elementsNumpad[buttonF.tag]) != nil{
                buttonF.addTarget(self, action: #selector(numberPress), for: .touchUpInside)
            } else {
                buttonF.addTarget(self, action: #selector(operationPress(_:)), for: .touchUpInside)
            }
            incElem+=1
        }
    }
    
    func anchorLabel(){
        resLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        resLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        resLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        resLabel.bottomAnchor.constraint(equalTo: viewNum.topAnchor).isActive = true
    }
    
    func anchorView(){
        viewNum.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -hightView).isActive = true
        viewNum.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        viewNum.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        viewNum.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(resLabel)
        view.addSubview(viewNum)
        anchorLabel()
        anchorView()
        numPud()
        // Do any additional setup after loading the view.
    }
    
    
    @objc func numberPress(_ button: UIButton){
        let tag = button.tag
        if resLabel.text == "0" {
            resLabel.text = "\(elementsNumpad[tag])"
        } else if let text = resLabel.text{
            
            resLabel.text = "\(text)\(elementsNumpad[tag])"
        }
    }
    
    @objc func operationPress(_ button: UIButton){
        
        let tag = button.tag
        if tag == 0 {
            resLabel.text = "0"
            operation = ""
            firstNum = nil
        }
        
        if tag == 1 {
            if let text = resLabel.text, resLabel.text != "0" {
                if Float(text)! > 0 {
                    resLabel.text = "-\(text)"
                }
                if Float(text)! < 0 {
                    resLabel.text = String(text.dropFirst())
                }
            }
        }
        
        if tag == 2 {
            if let text = resLabel.text, resLabel.text != "0"{
                var z: Float = Float(text)!
                z = z/100
                resLabel.text = String(z)
            }
        }
        if tag == 3 {
            if let text = resLabel.text, firstNum == nil {
                firstNum = Float(text)
                operation = "/"
                resLabel.text = "0"
            }
        }
        if tag == 7 {
            if let text = resLabel.text, firstNum == nil {
                firstNum = Float(text)
                operation = "*"
                resLabel.text = "0"
            }
        }
        if tag == 11 {
            if let text = resLabel.text, firstNum == nil {
                firstNum = Float(text)
                operation = "-"
                resLabel.text = "0"
            }
        }
        if tag == 15 {
            if let text = resLabel.text, firstNum == nil {
                firstNum = Float(text)
                operation = "+"
                resLabel.text = "0"
            }
        }
        if tag == 17 {
            if let text = resLabel.text, !(text.contains(",")){
                resLabel.text = "\(text).4"
            }
        }
        if tag == 18 {
            if firstNum != nil {
                
                switch operation{
                case "/":
                    let secondNum: Float = Float(resLabel.text!)!
                    let res: Float = firstNum! / secondNum
                    resLabel.text = String(res)
                    operation = ""
                    firstNum = nil
                    break
                case "*":
                    let secondNum: Float = Float(resLabel.text!)!
                    let res: Float = firstNum! * secondNum
                    resLabel.text = String(res)
                    operation = ""
                    firstNum = nil
                    break
                case "-":
                    let secondNum: Float = Float(resLabel.text!)!
                    let res: Float = firstNum! - secondNum
                    resLabel.text = String(res)
                    operation = ""
                    firstNum = nil
                    break
                case "+":
                    let secondNum: Float = Float(resLabel.text!)!
                    let res: Float = firstNum! + secondNum
                    resLabel.text = String(res)
                    operation = ""
                    firstNum = nil
                    break
                default:
                    break
                }
            }
        }
    }
}

