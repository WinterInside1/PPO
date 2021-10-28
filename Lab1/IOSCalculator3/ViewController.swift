

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var typing: Bool = false
    var count: Int = 0
    var count2: Int = 0
    
    @IBOutlet weak var radBut: UIButton!
    @IBOutlet weak var yinx: UIButton!
    @IBOutlet weak var secondMode: UIButton!
    @IBOutlet weak var twoInX: UIButton!
    @IBOutlet weak var logy: UIButton!
    @IBOutlet weak var log2: UIButton!
    @IBOutlet weak var sinMinus: UIButton!
    @IBOutlet weak var cosMinus: UIButton!
    @IBOutlet weak var tanMinus: UIButton!
    @IBOutlet weak var sinhMinus: UIButton!
    @IBOutlet weak var coshMinus: UIButton!
    @IBOutlet weak var tanhMinus: UIButton!
    
    @IBAction func digitPressed(_ sender: UIButton) {
        let currentDigit = sender.currentTitle!
        if typing{
            let currentDisplay = label.text!
            label.text = currentDisplay + currentDigit
        }else{
            label.text = currentDigit
            typing = true
        }
    }
    @IBAction func operationPressed(_ sender: UIButton) {
        calculatorModel.setOperand(displayValue)
        calculatorModel.performOperation(sender.currentTitle!)
        displayValue = calculatorModel.result!
        if(sender.currentTitle! == "Rad" || sender.currentTitle! == "Deg"){
            if(count%2 == 0){
                radBut.setTitle("Deg", for: .normal)
                count = count + 1
            }
            else{
                radBut.setTitle("Rad", for: .normal)
                count = count + 1
            }
        }
        secondMode.addTarget(self, action: #selector(secondClicked), for: .touchUpInside)
        
        typing = false
    }
    @IBAction func clear(_ sender: UIButton) {
        label.text = "0"
        typing = false
    }
    @IBAction func point(_ sender: UIButton) {
        if displayValue%1==0 {
            label.text = label.text! + "."
        }
    }
    @IBAction func ee(_ sender: UIButton) {
        if(sender.currentTitle != "EE"){
            label.text = label.text! + "e"+sender.currentTitle!
        }
        else{
            label.text = label.text! + "e"
        }
    }
    
    private var calculatorModel = CalculatorModel()
    var displayValue: Double{
        get{
            return Double(label.text!)!
        }
        set{
            if newValue%1==0 {
                label.text = String(newValue).replacingOccurrences(of: ".0", with: "", options: NSString.CompareOptions.literal, range: nil)
            }
            else{
                label.text = String(newValue)
            }
            
        }
    }
    @objc func secondClicked(_ sender: UIButton){
        if(count2%2 == 0){
            yinx.setTitle("y^x", for: .normal)
            twoInX.setTitle("2^x", for: .normal)
            logy.setTitle("logy", for: .normal)
            log2.setTitle("log2", for: .normal)
            sinMinus.setTitle("sin^(-1)", for: .normal)
            cosMinus.setTitle("cos^(-1)", for: .normal)
            tanMinus.setTitle("tan^(-1)", for: .normal)
            sinhMinus.setTitle("sinh^(-1)", for: .normal)
            coshMinus.setTitle("cosh^(-1)", for: .normal)
            tanhMinus.setTitle("tanh^(-1)", for: .normal)
            count2 = count2 + 1
        }
        else{
            radBut.setTitle("e^x", for: .normal)
            twoInX.setTitle("10^x", for: .normal)
            logy.setTitle("ln", for: .normal)
            log2.setTitle("log10", for: .normal)
            sinMinus.setTitle("sin", for: .normal)
            cosMinus.setTitle("cos", for: .normal)
            tanMinus.setTitle("tan", for: .normal)
            sinhMinus.setTitle("sinh", for: .normal)
            coshMinus.setTitle("cosh", for: .normal)
            tanhMinus.setTitle("tanh", for: .normal)
            count2 = count2 + 1
        }
    }
}
func %<N: BinaryFloatingPoint>(lhs: N, rhs: N) -> N {
    lhs.truncatingRemainder(dividingBy: rhs)
}
