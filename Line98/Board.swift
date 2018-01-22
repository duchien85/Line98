//
//  BoardModel.swift
//  Line98
//
//  Created by Glaphi on 22/01/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import Foundation

protocol BoardDelegate {
    func didInsert(_ balls: [Ball])
}

struct Board {
    /// The number of rows and of columns in the square board
    var delegate: BoardDelegate?
    let order: Int
    private var matrix: [[Cell]] = []
    
    init(order: Int) {
        self.order = order
        for row in 0..<order {
            var newRow: [Cell] = []
            for column in 0..<order {
                let cell: Cell = Cell.empty(Position(row: row, column: column))
                newRow.append(cell)
            }
            matrix.append(newRow)
        }
    }
    
    mutating func startNewGame() {
        clean()
        insertBalls()
        insertBalls()
    }
    
    mutating func moveBall(from: Position, to: Position) {
        guard let ball = self[from].ball else { return }
        self[to] = Cell.occupied(to, ball)
        insertBalls()
    }
    
    /// Array of the pending small balls
    private var smallBalls: [Ball] = []
    
    mutating private func insertBalls() {
        smallBalls.forEach { (ball) in
            ball.isBig = true
        }
        smallBalls.removeAll()
        
        for _ in 0..<1 {
            let positions: [Position] = emptyPositions
            
            if positions.isEmpty {
                gameOver()
                return
            }
            
            let index: Int = Int.random(max: positions.count)
            let ball: Ball = Ball(position: positions[index])
            smallBalls.append(ball)
            let position: Position = positions[index]
            let cell: Cell = Cell.occupied(position, ball)
            self[position] = cell
        }
        delegate?.didInsert(smallBalls)
    }
    
    mutating func gameOver() {
        print("Game Over")
        clean()
    }
    
    mutating func clean() {
        // if !occupiedPositions.isEmpty {}
    }
}

extension Board {
    subscript(position: Position) -> Cell {
        get { return matrix[position.row][position.column] }
        set { self.matrix[position.row][position.column] = newValue }
    }
    
    var emptyPositions: [Position] {
        var positions: [Position] = []
        matrix.forEach { (rows) in
            rows.forEach({ (cell) in
                if cell.ball == nil {
                    positions.append(cell.position)
                }
            })
        }
        return positions
    }
    
    var occupiedPositions: [Position] {
        var positions: [Position] = []
        matrix.forEach { (rows) in
            rows.forEach({ (cell) in
                if cell.ball != nil {
                    positions.append(cell.position)
                }
            })
        }
        return positions
    }
}
