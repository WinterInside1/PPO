

import Foundation
enum Operation{
    case constant(Double)
    case unaryOperation((Double) -> Double)
    case binaryOperation((Double, Double) -> Double)
    case equals
}

struct CalculatorModel{
    var myOperation: Dictionary<String, Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "m+": Operation.unaryOperation(storeNum),
        "Rad": Operation.unaryOperation(changeRadStatus),
        "Deg": Operation.unaryOperation(changeRadStatus),
        "sqrt(x)": Operation.unaryOperation(sqrt),
        "m-": Operation.unaryOperation(minusNum),
        "mc": Operation.unaryOperation(eraseNum),
        "2^x": Operation.unaryOperation({pow(2, $0)}),
        "mr": Operation.unaryOperation(showNum),
        "x!": Operation.unaryOperation(fac),
        "log10": Operation.unaryOperation({log10($0)}),
        "ln": Operation.unaryOperation({log($0)}),
        "%": Operation.unaryOperation({$0*0.01}),
        "sin": Operation.unaryOperation(sinMet),
        "sin^(-1)": Operation.unaryOperation(sinMinusMet),
        "cos^(-1)": Operation.unaryOperation(cosMinusMet),
        "tan^(-1)": Operation.unaryOperation(tanMinusMet),
        "tanh^(-1)": Operation.unaryOperation({atanh($0)}),
        "sinh^(-1)": Operation.unaryOperation({asinh($0)}),
        "cosh^(-1)": Operation.unaryOperation({acosh($0)}),
        "log2": Operation.unaryOperation({logC(val: $0,base: 2)}),
        "cos": Operation.unaryOperation(cosMet),
        "tan": Operation.unaryOperation(tanMet),
        "Rand": Operation.unaryOperation({_ in Double.random(in: 0...1)}),
        "sinh": Operation.unaryOperation({sinh($0)}),
        "cosh": Operation.unaryOperation({cosh($0)}),
        "tanh": Operation.unaryOperation({tanh($0)}),
        "+/-": Operation.unaryOperation({$0*(-1)}),
        "x^2": Operation.unaryOperation({$0*$0}),
        "x^3": Operation.unaryOperation({$0*$0*$0}),
        "e^x": Operation.unaryOperation({pow(M_E,$0)}),
        "10^x": Operation.unaryOperation({pow(10,$0)}),
        "sqrt3(x)": Operation.unaryOperation({pow($0,1/3)}),
        "1/x": Operation.unaryOperation({1/$0}),
        "+": Operation.binaryOperation({$0+$1}),
        "logy": Operation.binaryOperation({logC(val: $0,base: $1)}),
        "y^x": Operation.binaryOperation({pow($1,$0)}),
        "x^y": Operation.binaryOperation({pow($0,$1)}),
        "-": Operation.binaryOperation({$0-$1}),
        "×": Operation.binaryOperation({$0*$1}),
        "÷": Operation.binaryOperation({$0/$1}),
        "=": Operation.equals
    ]
    private var globalValue : Double?
    private var saving: SaveFirstOperandAndOperation?
    
    mutating func setOperand(_ operand: Double){
        globalValue = operand
    }
    
    mutating func performOperation(_ operation: String){
        let symbol = myOperation[operation]!
        
        switch symbol {
        case .constant(let value):
            globalValue = value
        case .unaryOperation(let function):
            globalValue = function(globalValue!)
        case .binaryOperation(let function):
            saving = SaveFirstOperandAndOperation(firstOperand: globalValue!, operation: function)
        case .equals:
            if globalValue != nil {
                globalValue = saving?.performOperationWith(secondOperand: globalValue!)
            }
        }
    }
    var result:Double?{
        get{
            return globalValue
        }
    }
    struct SaveFirstOperandAndOperation {
        var firstOperand: Double
        var operation: (Double, Double) -> Double
        
        func performOperationWith(secondOperand op2: Double) -> Double{
            return operation(firstOperand, op2)
        }
    }
}

private var storedNum:Double = 0
private var radStatus:Bool = true

func fac(a: Double) -> Double {
    let n = a
    if(n == 1 || n == 0){
      return 1
    }
    return n*fac(a: n-1)
}
func storeNum(num: Double) -> Double{
    storedNum = storedNum + num
    return num
}
func minusNum(num: Double) -> Double{
    storedNum = storedNum - num
    return num
}
func eraseNum(num: Double) -> Double{
    storedNum = 0
    return num
}
func showNum(num: Double) -> Double{
    return storedNum
}
func changeRadStatus(num: Double) -> Double{
    if(radStatus){
        radStatus = false
    }
    else{
        radStatus = true
    }
    return num
}
func sinMet(num: Double) -> Double{
    if(radStatus){
        return sin(num*Double.pi/180)
    }
    return sin(num)
}
func sinMinusMet(num: Double) -> Double{
    if(radStatus){
        return asin(num)*180/Double.pi
    }
    return asin(num)
}
func cosMet(num: Double) -> Double{
    if(radStatus){
        return cos(num*Double.pi/180)
    }
    return cos(num)
}
func cosMinusMet(num: Double) -> Double{
    if(radStatus){
        return acos(num)*180/Double.pi
    }
    return acos(num)
}
func tanMet(num: Double) -> Double{
    if(radStatus){
        return tan(num*Double.pi/180)
    }
    return tan(num)
}
func tanMinusMet(num: Double) -> Double{
    if(radStatus){
        return atan(num)*180/Double.pi
    }
    return atan(num)
}
func logC(val: Double, base: Double) -> Double {
    return log(val)/log(base)
}

