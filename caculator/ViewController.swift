import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var calculatorOperations: UILabel!
    @IBOutlet weak var calculatorResult: UILabel!
    
    var operations:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
    }
    
    func clearAll() {
        operations = ""
        calculatorOperations.text = ""
        calculatorResult.text = ""
    }
    
    func addNewSymbols(value: String) {
        operations = operations + value
        calculatorOperations.text = operations
    }
    
    func resultFormat(result: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 6
        
        return numberFormatter.string(from: NSNumber(value: result)) ?? ""
    }

    
    func lastCharIsNum() -> Bool {
        if let last = operations.last {
            if last == "." {
                operations += "0"
                calculatorOperations.text = operations
                return true
            }
            return last.isNumber || last == ")"
        }
        return false
    }
    
    func lastCharIsNotBracket() -> Bool {
        if operations.last == ")" {
            return false
        }
        else {
            return true
        }
    }

    @IBAction func nineButton(_ sender: Any) {
        if lastCharIsNotBracket() {
                addNewSymbols(value: "9")
            }
    }
    @IBAction func eightButton(_ sender: Any) {
        if lastCharIsNotBracket() {
                addNewSymbols(value: "8")
            }
    }
    @IBAction func sevenButton(_ sender: Any) {
        if lastCharIsNotBracket() {
                addNewSymbols(value: "7")
            }
    }
    @IBAction func sixButton(_ sender: Any) {
        if lastCharIsNotBracket() {
                addNewSymbols(value: "6")
            }
    }
    @IBAction func fiveButton(_ sender: Any) {
        if lastCharIsNotBracket() {
                addNewSymbols(value: "5")
            }
    }
    @IBAction func fourButton(_ sender: Any) {
        if lastCharIsNotBracket() {
                addNewSymbols(value: "4")
            }
    }
    @IBAction func threeButton(_ sender: Any) {
        if lastCharIsNotBracket() {
                addNewSymbols(value: "3")
            }
    }
    @IBAction func twoButton(_ sender: Any) {
        if lastCharIsNotBracket() {
                addNewSymbols(value: "2")
            }
    }
    @IBAction func oneButton(_ sender: Any) {
        if lastCharIsNotBracket() {
                addNewSymbols(value: "1")
            }
    }
    @IBAction func zeroButton(_ sender: Any) {
        if lastCharIsNotBracket() {
                addNewSymbols(value: "0")
            }
    }
    @IBAction func pointButton(_ sender: Any) {
        if lastCharIsNum() {
                addNewSymbols(value: ".")
            }
    }
    @IBAction func equalsButton(_ sender: Any) {
        if lastCharIsNum() {
            let expressionString = operations
                .replacingOccurrences(of: "×", with: "*")
                .replacingOccurrences(of: "÷", with: "*1.0/")
            
            if expressionString.contains("/0") {
                calculatorResult.text = "Divide by zero"
                return
            }
            
            let components = expressionString.split(separator: "%").map { String($0).trimmingCharacters(in: .whitespaces) }
            if components.count == 2 {
                if let leftOperand = Double(components[0]), let rightOperand = Double(components[1]) {
                    let result = leftOperand.truncatingRemainder(dividingBy: rightOperand)
                    calculatorResult.text = resultFormat(result: result)
                    return
                }
            }

            let expression = NSExpression(format: expressionString)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = resultFormat(result: result)
            calculatorResult.text = resultString
        }
    }
    @IBAction func plusButton(_ sender: Any) {
        if lastCharIsNum() {
                addNewSymbols(value: "+")
            }
    }
    @IBAction func minusButton(_ sender: Any) {
        if lastCharIsNum() {
                addNewSymbols(value: "-")
            }
    }
    @IBAction func multiplyButton(_ sender: Any) {
        if lastCharIsNum() {
                addNewSymbols(value: "×")
            }
    }
    @IBAction func divideButton(_ sender: Any) {
        if lastCharIsNum() {
                addNewSymbols(value: "÷")
            }
    }
    @IBAction func percentButton(_ sender: Any) {
        if lastCharIsNum() {
                addNewSymbols(value: "%")
            }
    }
    @IBAction func plusMinusButton(_ sender: Any) {
        if operations.isEmpty {
            return
        }

        if operations.hasSuffix(")") {
            operations = String(operations.dropFirst(2).dropLast())
        } else {
            operations = "(-" + operations + ")"
        }
        
        calculatorOperations.text = operations
    }
    @IBAction func allClearButton(_ sender: Any) {
        clearAll()
    }
}

