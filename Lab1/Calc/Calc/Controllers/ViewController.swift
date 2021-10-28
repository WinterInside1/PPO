//
//  ViewController.swift
//  Calc
//
//  Created by Dany Ryaby on 15.09.21.
//

import UIKit
import SnapKit

public enum CalcStyle {
    case simple
    case scientific
}

final class ViewController: UIViewController {
    @IBOutlet weak var calcTextField: UITextField!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var fstStackView: UIStackView!
    @IBOutlet weak var secStackView: UIStackView!
    @IBOutlet weak var thdStackView: UIStackView!
    @IBOutlet weak var fthStackView: UIStackView!
    @IBOutlet weak var fifthStackView: UIStackView!
    
    lazy var allSubviews: [UIStackView] = { [fstStackView,
                                             secStackView,
                                             thdStackView,
                                             fthStackView,
                                             fifthStackView] }()
    
    var operations: [String] = ["AC", "<", "%", "/", "x", "-",
                                "+", "=", "^2", "^3", "!"]
    var baseOps: [String] = ["/", "x", "-", "+", "="]
    var sqrtOps: [String] = ["√", "3√"]
    var powOps: [String] = ["^2", "^3", "^"]
    var style: CalcStyle = .simple

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if UIDevice.current.orientation.isLandscape {
            setCellsForLandscapeOrientation(screenWidth: UIScreen.main.bounds.width)
        } else {
            setCellsForPortraitOrientation(screenWidth: UIScreen.main.bounds.width)
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            style = .scientific
            setCellsForLandscapeOrientation(screenWidth: UIScreen.main.bounds.width)
        } else {
            style = .simple
            setCellsForPortraitOrientation(screenWidth: UIScreen.main.bounds.width)
        }
    }

    func setCellsForPortraitOrientation(
        screenWidth: CGFloat
    ) {
        allSubviews.forEach({ $0.subviews.forEach({ $0.removeFromSuperview() }) })
        var titleIndex = 0
        let itemsTitleArray: [String] = ["AC", "<", "%", "/",
                                         "7", "8", "9", "*",
                                         "4", "5", "6", "-",
                                         "1", "2", "3", "+",
                                         "0", ".", "^", "="]
        let itemsCount: Int = 4
        let spacing: CGFloat = 5
        let cellWidth = (screenWidth - spacing * 3) / 3
        let cellHeight = cellWidth
        mainStackView.spacing = spacing
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        let levelsCount = 5
        for levelIndex in 0..<levelsCount {
            for viewIndex in 0..<itemsCount {
                let cellView = CalcCellView.loadFromNib()
                cellView.delegate = self
                cellView.snp.makeConstraints {
                    $0.height.equalTo(cellHeight)
                    $0.width.equalTo(cellWidth)
                }
                if levelIndex == levelsCount - 1 {
                    if viewIndex == itemsCount - 1 {
                        cellView.setColor(color: .purple)
                    } else {
                        cellView.setColor(color: .systemPink)
                    }
                } else {
                    if viewIndex == itemsCount - 1 {
                        cellView.setColor(color: .purple)
                    } else {
                        cellView.setColor(color: .systemPink)
                    }
                }
                cellView.setTitle(text: itemsTitleArray[titleIndex])
                titleIndex += 1
                allSubviews[levelIndex].addArrangedSubview(cellView)
                allSubviews[levelIndex].spacing = 5
                allSubviews[levelIndex].sizeToFit()
            }
            mainStackView.sizeToFit()
        }
    }
    
    func setCellsForLandscapeOrientation(
        screenWidth: CGFloat
    ) {
        allSubviews.forEach({ $0.subviews.forEach({ $0.removeFromSuperview() }) })
        var titleIndex = 0
        let itemsTitleArray: [String] = ["(", ")", "AC", "<", "%", "/",
                                         "sin", "cos", "7", "8", "9", "*",
                                         "^2", "^3", "4", "5", "6", "-",
                                         "!", "pi", "1", "2", "3", "+",
                                         "√", "3√", "0", ".", "^", "="]
        let itemsCount: Int = 6
        let spacing: CGFloat = 5
        let cellWidth = (screenWidth - spacing * 5) / 6
        let cellHeight = cellWidth
        mainStackView.spacing = spacing
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        let levelsCount = 5
        for levelIndex in 0..<levelsCount {
            for viewIndex in 0..<itemsCount {
                let cellView = CalcCellView.loadFromNib()
                cellView.delegate = self
                cellView.snp.makeConstraints {
                    $0.height.equalTo(cellHeight)
                    $0.width.equalTo(cellWidth)
                }
                if levelIndex == levelsCount - 1 {
                    if viewIndex == itemsCount - 1 {
                        cellView.setColor(color: .purple)
                    } else if viewIndex >= itemsCount - 4 {
                        cellView.setColor(color: .systemPink)
                    } else {
                        cellView.setColor(color: .blue)
                    }
                } else {
                    if viewIndex == itemsCount - 1 {
                        cellView.setColor(color: .purple)
                    } else if viewIndex >= itemsCount - 4 {
                        cellView.setColor(color: .systemPink)
                    } else {
                        cellView.setColor(color: .blue)
                    }
                }
                cellView.setTitle(text: itemsTitleArray[titleIndex])
                titleIndex += 1
                allSubviews[levelIndex].addArrangedSubview(cellView)
                allSubviews[levelIndex].spacing = 5
                allSubviews[levelIndex].sizeToFit()
            }
            mainStackView.sizeToFit()
        }
    }
    
    func fact(number: Int64) -> Int64 {
        if number == 0 {
            return 1
        } else {
            return number * fact(number: number - 1)
        }
    }
}

extension ViewController: CellPressedDelegateProtocol {
    func cellPressed(text: String) {
        if self.calcTextField.text?.count == 1 && self.calcTextField.text == "0" {
            if text == "." {
                self.calcTextField.text?.append(text)
            } else if text != "0" && !operations.contains(text) {
                self.calcTextField.text = text
            }
        } else {
            switch text {
            case "AC":
                self.calcTextField.text = "0"
            case "<":
                self.calcTextField.text?.removeLast()
                if self.calcTextField.text?.isEmpty == true {
                    self.calcTextField.text = "0"
                }
            case "=":
                if self.calcTextField.text?.contains("3√") == true {
                    if let percIndex = self.calcTextField.text?.firstIndex(of: "√"),
                       let endIndex = self.calcTextField.text?.endIndex {
                        var value = self.calcTextField.text
                            .wrappedValue[percIndex..<endIndex]
                        value.removeFirst()
                        let ans = pow(Double(value) ?? 0, 1.0 / 3.0)
                        self.calcTextField.text = String(describing: ans)
                        return
                    }
                }

                if self.calcTextField.text?.contains("√") == true {
                    if let percIndex = self.calcTextField.text?.firstIndex(of: "√"),
                       let endIndex = self.calcTextField.text?.endIndex {
                        var value = self.calcTextField.text
                            .wrappedValue[percIndex..<endIndex]
                        value.removeFirst()
                        let ans = sqrt(Double(value) ?? 1)
                        self.calcTextField.text = String(describing: ans)
                        return
                    }
                }

                if self.calcTextField.text?.contains("%") == true {
                    if let percIndex = self.calcTextField.text?.firstIndex(of: "%"),
                       let endIndex = self.calcTextField.text?.endIndex,
                          let startIndex = self.calcTextField.text?.startIndex {
                        let firstValue = Double(self.calcTextField.text
                            .wrappedValue[startIndex..<percIndex]) ?? 0
                        var secondValue = self.calcTextField.text
                            .wrappedValue[percIndex..<endIndex]
                        secondValue.removeFirst()
                        let ans = firstValue.truncatingRemainder(dividingBy: Double(secondValue) ?? 1)
                        self.calcTextField.text = String(describing: ans)
                        return
                    }
                }

                if self.calcTextField.text?.contains("^") == true {
                    if let powIndex = self.calcTextField.text?.firstIndex(of: "^"),
                       let endIndex = self.calcTextField.text?.endIndex,
                          let startIndex = self.calcTextField.text?.startIndex {
                        let firstValue = Double(self.calcTextField.text
                            .wrappedValue[startIndex..<powIndex]) ?? 0
                        var secondValue = self.calcTextField.text
                            .wrappedValue[powIndex..<endIndex]
                        secondValue.removeFirst()
                        if secondValue.contains(" ") { secondValue.removeLast() }
                        self.calcTextField.text = String(describing: pow(firstValue, Double(secondValue) ?? 0))
                        return
                    }
                }
                
                if self.calcTextField.text?.contains("!") == true {
                    if let endIndex = self.calcTextField.text?.firstIndex(of: "!"),
                       let startIndex = self.calcTextField.text?.startIndex {
                        let toCalculateString = self.calcTextField.text
                            .wrappedValue[startIndex..<endIndex]
                        self.calcTextField.text = fact(number: Int64(toCalculateString) ?? 0).description
                    }
                }
                
                if self.calcTextField.text == "pi" {
                    self.calcTextField.text = String(format: "%.03f", Double.pi)
                }
                
                if self.calcTextField.text?.contains("sin") == true {
                    if let startIndex = self.calcTextField.text?.firstIndex(of: "("),
                       let endIndex = self.calcTextField.text?.firstIndex(of: ")") {
                        var toCalculateString = self.calcTextField.text
                            .wrappedValue[startIndex..<endIndex]
                        toCalculateString.removeFirst()
                        self.calcTextField.text = String(format: "%.03f", sin(Double(toCalculateString) ?? 0))
                        return
                    } else {
                        self.calcTextField.text = "0"
                    }
                }
                
                if self.calcTextField.text?.contains("cos") == true {
                    if let startIndex = self.calcTextField.text?.firstIndex(of: "("),
                       let endIndex = self.calcTextField.text?.firstIndex(of: ")") {
                        var toCalculateString = self.calcTextField.text
                            .wrappedValue[startIndex..<endIndex]
                        toCalculateString.removeFirst()
                        self.calcTextField.text = String(format: "%.03f", cos(Double(toCalculateString) ?? 0))
                        return
                    } else {
                        self.calcTextField.text = "0"
                    }
                }
                
                let expression = NSExpression(format: self.calcTextField.text ?? "")
                if self.calcTextField.text?.contains(".") == false {
                    if let value = expression.expressionValue(with: nil, context: nil) as? Int {
                        self.calcTextField.text = String(value)
                    }
                } else {
                    if let value = expression.expressionValue(with: nil, context: nil) as? Double {
                        self.calcTextField.text = String(format: "%.02f", value)
                    }
                }
            default:
                if baseOps.contains(text) {
                    self.calcTextField.text?.append(" " + text + " ")
                } else if sqrtOps.contains(text) {
                    self.calcTextField.text?.append(" " + text)
                } else if powOps.contains(text) {
                    if self.calcTextField.text?.last?.isNumber == true {
                        if text == "^" {
                            self.calcTextField.text?.append(text)
                        } else {
                            self.calcTextField.text?.append(text + " ")
                        }
                    }
                } else {
                    self.calcTextField.text?.append(text)
                }
            }
        }
    }
}

extension Optional where Wrapped == String {
    var wrappedValue: String {
        switch self {
        case .some(let value):
            return value
        default:
            return ""
        }
    }
}
