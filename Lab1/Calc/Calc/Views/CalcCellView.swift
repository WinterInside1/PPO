//
//  CalcCellView.swift
//  Calc
//
//  Created by Dany Ryaby on 27.09.21.
//

import UIKit

public protocol CellPressedDelegateProtocol: AnyObject {
    func cellPressed(text: String)
}

class CalcCellView: UIView {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var viewText: UILabel!
    
    weak var delegate: CellPressedDelegateProtocol?
    
    init() {
        super.init(frame: CGRect())
        let tap = UITapGestureRecognizer(target: self, action: #selector(pressed))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let tap = UITapGestureRecognizer(target: self, action: #selector(pressed))
        self.addGestureRecognizer(tap)
    }

    func setColor(color: UIColor) {
        self.backgroundView.backgroundColor = color
    }

    func setTitle(text: String) {
        self.viewText.text = text
    }
    
    @objc func pressed() {
        delegate?.cellPressed(text: viewText.text ?? "")
    }
}
