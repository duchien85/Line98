//
//  BoardView.swift
//  Line98
//
//  Created by Glaphi on 22/01/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import UIKit

class BoardView: UIView {
    
    let board: Board = Board(order: 4)
    
    private var buttons: [[CellButton]] = []
    
    private var side: CGFloat {
        return bounds.width / CGFloat(board.order)
    }
    
    private func frame(from position: Position) -> CGRect {
        let x: CGFloat = CGFloat(position.column) * side
        let y: CGFloat = CGFloat(position.row) * side
        return CGRect(x: x, y: y, width: side, height: side)
    }
    
    @objc func printPosition(_ sender: CellButton) {
        print(sender.position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Creating matrix of buttons
        for row in 0..<board.order {
            var newRow: [CellButton] = []
            for column in 0..<board.order {
                let button: CellButton = CellButton(position: Position(row: row, column: column))
                button.addTarget(self, action: #selector(printPosition(_:)), for: .touchUpInside)
                newRow.append(button)
                addSubview(button)
            }
            buttons.append(newRow)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Giving frames to buttons
        for row in buttons {
            for button in row {
                button.frame = frame(from: button.position)
            }
        }
    }
}

class CellButton: UIButton {
    
    private(set) var position: Position!
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public required init(position: Position, frame: CGRect? = nil) {
        super.init(frame: frame ?? .zero)
        self.position = position
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
    }
}
