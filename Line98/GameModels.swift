//
//  GameModels.swift
//  Line98
//
//  Created by Glaphi on 22/01/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import UIKit

typealias Position = (row: Int, column: Int)
typealias Matrix = [[MatrixButton]]

enum Cell {
    case empty
    case inTransition // Small Ball just appeared
    case occupied   // by Big Ball
    
    func getItem(frame: CGRect) -> MatrixButton {
        switch self {
        case .empty:
            let btn: MatrixButton = MatrixButton(frame: frame)
            btn.isEnabled = false
            btn.layer.cornerRadius = 5
            return btn
        case .inTransition:
            let btn: MatrixButton = MatrixButton(frame: frame)
            btn.isEnabled = false
            btn.layer.cornerRadius = 80
            return btn
        case .occupied:
            let btn: MatrixButton = MatrixButton(frame: frame)
            btn.isEnabled = true
            btn.layer.cornerRadius = 45
            return btn
        }
    }
}

struct Ball {
    var position: Position
    var color: UIColor
    var isBig: Bool
    
    private let colorArray: [UIColor] = [.softRed, .softGray, .softPurple, .softYellow, .softLigthBlue, .softAquamarine, .softLightGreen]
    
    init(position: Position) {
        self.position = position
        color = colorArray.randomItem()!
        isBig = false
    }
}

class MatrixButton: UIButton {
    var paramethers: Dictionary<String, Any>
    
    @objc func changeHeart(_ sender: MatrixButton)  {
        sender.isSelected = (sender.isSelected == true) ? false : true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.paramethers = [:]
        super.init(coder: aDecoder)
    }
    
    public override required init(frame: CGRect) {
        self.paramethers = [:]
        super.init(frame: frame)
        
        self.tag = -1
        self.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        self.setImage(#imageLiteral(resourceName: "heartFill"), for: .selected)
        self.backgroundColor = UIColor.cyan
        self.addTarget(self, action: #selector(changeHeart(_:)), for: .touchUpInside)
    }
}
