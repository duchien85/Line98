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
    func didDelete(in positions: [Position])
}

struct Board {
    var delegate: BoardDelegate?
    let order: Int
    private var matrix: [[Cell]] = []
    private var minToRemove: Int = 3
    
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
    
    /// Update the `position` of the `ball` with the new selected position
    mutating func moveBall(from initialPosition: Position, to position: Position) {
        guard let ball = self[initialPosition].ball else { return }
        deletedBallPositions.removeAll()
        
        // Update position of this ball
        ball.position =  position
        self[initialPosition] = Cell.empty(initialPosition)
        self[position] = Cell.occupied(position, ball)
        
        // Check that that there aren't same color balls together
        let matchingPositions: [Position] = matchingPositionsAround(position)
        matchingPositions.forEach { (position) in
            deletedBallPositions.append(position)
            self[position] = Cell.empty(position)
        }
        delegate?.didDelete(in: deletedBallPositions)
        if deletedBallPositions.isEmpty {
            insertBalls()
        }
    }
    
    /// Array of the pending small balls
    private var smallBalls: [Ball] = []
    /// Array of deleted balls
    private var deletedBallPositions: [Position] = []

    
    mutating private func insertBalls() {
        smallBalls.forEach { (ball) in
            ball.isBig = true
        }
        smallBalls.removeAll()
        
        for _ in 0..<3 {
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
    
    /// Array of available for move empty positions.
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
    
    /// Array of obstacle positions that are occupied by a `ball`.
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
    
    /// Check that the row and the column are within matrix borders
    private func isInMatrix(_ p: Position) -> Bool {
        return (p.row<self.order) && (p.column<order) && (p.column>=0) && (p.row>=0)
    }
    
    /// Next position using provided increments for row and column
    private func nextPosition(_ p: Position, rowIncrement: Int, columnIncrement: Int) -> Position {
        return Position(row: p.row + rowIncrement, column: p.column + columnIncrement)
    }
    
    /// Getting array of positions with balls of matching colors in one of 3 possible lines (horizontal, vertical or diagonal)
    private func matchingPositions(in direction: Direction, position: Position) ->  [Position]  {
        var positions: [Position] = []
        var i: Int = 0
        var j: Int = 0
        switch direction {
        case .row:
            i = 0
            j = 1
        case .column:
            i = 1
            j = 0
        case .diagonal:
            i = 1
            j = 1
        case .antidiagonal:
            i = 1
            j = -1
        }
        // Check one direction
        var next = nextPosition(position, rowIncrement: 0, columnIncrement: 0)
        while isInMatrix(next) && (self[next].colorIndex == self[position].colorIndex) {
            positions.append(next)
            next = nextPosition(next, rowIncrement: i, columnIncrement: j)
        }
        // Check oposite direction
        if !positions.isEmpty {
            next = Position(row: positions.last!.row, column: positions.last!.column)
            positions.removeAll()
            while isInMatrix(next) && (self[next].colorIndex == self[position].colorIndex) {
                positions.append(next)
                next = nextPosition(next, rowIncrement: i * (-1), columnIncrement: j * (-1))
            }
        }
        if positions.count < minToRemove { positions.removeAll() }
        return positions
    }
    
    /// Checks matching balls in all possible directions and returns array of their positions
    private func matchingPositionsAround(_ position: Position) -> [Position] {
        var positions: [Position] = []
        guard let ball = self[position].ball else { return []}

        positions = matchingPositions(in: .row, position: ball.position)
        positions.append(contentsOf: matchingPositions(in: .column, position: ball.position))
        positions.append(contentsOf: matchingPositions(in: .diagonal, position: ball.position))
        positions.append(contentsOf: matchingPositions(in: .antidiagonal, position: ball.position))
        
        return positions
    }
}
