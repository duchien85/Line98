//
//  GameModels.swift
//  Line98
//
//  Created by Glaphi on 22/01/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import UIKit


struct Position {
    let row: Int
    let column: Int
}

enum Cell {
    case empty(Position)
    case occupied(Position, Ball)   //  with a Ball

    var position: Position {
        switch self {
        case .empty(let position):
            return (position)
        case .occupied((let position), _):
            return (position)
        }
    }
    
    var ball: Ball? {
        switch self {
        case .empty(_):
            return nil
        case .occupied((_), let ball):
            return ball
        }
    }
}

struct Ball {
    var position: Position
    var isBig: Bool = false // Making them always small when they appear.
    
    private var colorIndex: Int  // Color cannot change during the game
    private static let colors: [Int] = Array(0..<7) // Array for picking a random color index
    
    init(position: Position) {
        self.position = position
        colorIndex = Ball.colors.randomItem()!
    }
}

typealias Matrix = [[MatrixButton]]

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
