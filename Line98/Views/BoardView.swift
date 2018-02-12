//
//  BoardView.swift
//  Line98
//
//  Created by Glaphi on 22/01/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import UIKit

class BoardView: UIView, BoardDelegate {
    
    var board: Board = Board(order: 9)
    
    private var buttons: [[CellButton]] = []
    private var ballViews: [BallView] = []
    private var animatedBall: BallView? = nil
    
    // Getting sizes of the views
    private var buttonSide: CGFloat { return bounds.width / CGFloat(board.order) }
    private var smallBallDiameter: CGFloat { return  buttonSide * 0.3 }
    private var bigBallDiameter: CGFloat { return buttonSide * 0.85 }
    
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
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 2
        // Set frames to buttons
        for row in buttons {
            for button in row {
                button.frame = frame(from: button.position, side: buttonSide)
            }
        }
        setFramesForBallViews()
    }
    
    /// Return the frame when provided with the `position` inside of the board matrix
    /// and the `side` of the square in which the item needs to be inscribed in.
    private func frame(from position: Position, side: CGFloat) -> CGRect {
        let x: CGFloat = CGFloat(position.column) * side
        let y: CGFloat = CGFloat(position.row) * side
        return CGRect(x: x, y: y, width: side, height: side)
    }
    
    @objc private func tapped(_ cell: CellButton) {
        board.tapped(cell.position)
    }
    
    /// Set frames for `ball views` inside the `board view`
    private func setFramesForBallViews() {
        ballViews.forEach { (ballView) in
            if ballView != animatedBall {
            let side: CGFloat = ballView.ball.isBig ? bigBallDiameter : smallBallDiameter
            let position: Position = ballView.position
            ballView.frame = frame(from: position, side: side)
            ballView.center = buttons[position.row][position.column].center
            }
        }
    }
    
    /// Create a 2d array of buttons
    private func createButtons() {
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
extension BoardView {
    
    subscript(position: Position) -> CellButton {
        get { return buttons[position.row][position.column] }
        set { self.buttons[position.row][position.column] = newValue }
    }
}
// MARK: - BoardDelegate
extension BoardView {
    /// Creates `Ball Views` for each `ball` that was randomly created by the `board`
    
    func animate(_ ball: BallView, path: [CGPoint], index: Int) {
        if !path.isEmpty {
            UIView.animate(withDuration: 0.5, animations: {
                ball.center = path[index]
            }, completion: { ( true) in
                let i: Int = index + 1
                    if i < path.count {
                self.animate(ball, path: path, index: index+1)
                } 
            })
        }
    }
    
    func foundWalkablePath(_ initialPosition: Position, positions: [Position]) {
        var path: [CGPoint] = [self[initialPosition].center]
        positions.forEach { (pos) in
            path.append(self[pos].center)
            print(pos)
        }
        let ball: BallView? = ballViews.filter({ (ball) -> Bool in
            return ball.position == initialPosition
        }).first
        animatedBall = ball
        animate(ball!, path: path, index: 0)
    }
    
    func didInsert(_ balls: [Ball]) {
        balls.forEach { (ball) in
            let ballView = BallView(ball)
            ballViews.append(ballView)
            self.addSubview(ballView)
        }
    }
    
    func didDelete(in positions: [Position]) {
        positions.forEach { (pos) in
            ballViews.forEach({ (view) in
                if view.position == pos {
                    view.removeFromSuperview()
                }
            })
        }
    }
}
