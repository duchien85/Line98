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

class Board {
    var delegate: BoardDelegate?
    let pathfinder = AStarPathfinder()
    var path: [Position]?
    let order: Int
    
    private var matrix: [[Cell]] = []
    private var minToRemove: Int = 3
    /// Array of the pending small balls
    private var smallBalls: [Ball] = []
    /// Array of deleted balls
    private var deletedBallPositions: [Position] = []
    
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
        pathfinder.dataSource = self
    }
    
    func startNewGame() {
        clean()
        insertBalls()
        insertBalls()
    }
    
    /// Update the `position` of the `ball` with the new selected position
    func moveBall(from initialPosition: Position, to position: Position) {
        guard let ball = self[initialPosition].ball else { return }
        deletedBallPositions.removeAll()
        
        // Update position of this ball
        path = pathfinder.shortestPath(from: initialPosition, to: position)
        if let path = path {
            print("Path Found: ")
            for position in path { print(position) }
            print("Destination was successfully reached")
        }
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
    
    private func insertBalls() {
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
    
    func gameOver() {
        print("Game Over")
        clean()
    }
    
    func clean() {
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
    fileprivate func isInMatrix(_ p: Position) -> Bool {
        return (p.row<self.order) && (p.column<order) && (p.column>=0) && (p.row>=0)
    }
    
    /// Getting array of positions with balls of matching colors in one of `minToRemove` possible lines (horizontal, vertical or diagonal)
    private func matchingPositions(in direction: Direction, position: Position) ->  [Position]  {
        var positions: [Position] = []
        var position: Position = position
        let i: Int = direction.i
        let j: Int = direction.j
        let color = self[position].colorIndex
        // Change this nexting function thingy
        func colorAt(_ p: Position) -> Int? { return self[p].colorIndex }
        
        func checkThroughOneDirection(forward: Bool) {
            while isInMatrix(position) && (colorAt(position) == color) {         // Check line in one direction
                positions.append(position)
                position = forward ? position.next(rowIncrement: i, columnIncrement: j) : position.next(rowIncrement: i * (-1), columnIncrement: j * (-1))
            }
            if forward {    // Check line in the oposite direction
                position = positions.last!
                positions.removeAll()
                checkThroughOneDirection(forward: false)
            }
        }
        
        checkThroughOneDirection(forward: true)
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

// MARK: - PathFinderDataSource

extension Board: PathFinderDataSource {
    
    func walkableAdjacentPositions(for position: Position) -> [Position] {
        var neighbors: [Position] = [position.top, position.bottom, position.left, position.right]
        neighbors = neighbors.filter({ (pos) -> Bool in
            ((isInMatrix(pos)) && (self[pos].ball == nil))
        })
        return neighbors
    }
    
    func costToMove(from position: Position, to neighborPosition: Position) -> Int {
        return 1
    }
}


