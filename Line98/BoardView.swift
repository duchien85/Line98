//
//  BoardView.swift
//  Line98
//
//  Created by Glaphi on 22/01/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import UIKit

class BoardView: UIView, BoardDelegate {
    
    var board: Board = Board(order: 6)
    
    private var buttons: [[CellButton]] = []
    private var ballViews: [BallView] = []
    
    private var buttonSide: CGFloat {
        return bounds.width / CGFloat(board.order)
    }
    
    private var smallBallDiameter: CGFloat {
        return  buttonSide/2
    }
    
    private var bigBallDiameter: CGFloat {
        return buttonSide - 15
    }
    
    private func frame(from position: Position, side: CGFloat) -> CGRect {
        let x: CGFloat = CGFloat(position.column) * side
        let y: CGFloat = CGFloat(position.row) * side
        return CGRect(x: x, y: y, width: side, height: side)
    }
    
    private var initialPosition: Position? = nil
    
    @objc func tapped(_ cell: CellButton) {
        print(cell.position)
        if let position = initialPosition {
            let finalPosition: Position = cell.position
            guard board[finalPosition].ball == nil else { return }
            moveItem(from: position, to: finalPosition)
        } else {
            let startPosition: Position = cell.position
            guard let ball = board[startPosition].ball, ball.isBig else { return }
            initialPosition = startPosition
            print("yay")
        }
    }
    
    private func moveItem(from: Position, to: Position) {
        board.moveBall(from: from, to: to)
        initialPosition = nil
        setBallViewsFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        board.delegate = self
        createButtons()
        board.startNewGame()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Set frames to buttons
        for row in buttons {
            for button in row {
                button.frame = frame(from: button.position, side: buttonSide)
            }
        }
        // Set frames to ballViews
        setBallViewsFrame()
    }
    
    /// Sets frames for ballViews
    func setBallViewsFrame() {
        ballViews.forEach { (ballView) in
            let side: CGFloat = ballView.ball.isBig ? bigBallDiameter : smallBallDiameter
            let position: Position = ballView.position
            ballView.frame = frame(from: position, side: side)
            ballView.center = buttons[position.row][position.column].center
        }
    }
    
    func createButtons() {
        for row in 0..<board.order {
            var newRow: [CellButton] = []
            for column in 0..<board.order {
                let button: CellButton = CellButton(position: Position(row: row, column: column))
                button.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
                newRow.append(button)
                addSubview(button)
            }
            buttons.append(newRow)
        }
    }
}

// MARK: - BoardDelegate
extension BoardView {
    func didInsert(_ balls: [Ball]) {
        balls.forEach { (ball) in
            let ballView = BallView(ball)
            ballViews.append(ballView)
            self.addSubview(ballView)
            print("added balls")
        }
    }
}
