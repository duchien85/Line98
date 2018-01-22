//
//  GameModels.swift
//  Line98
//
//  Created by Glaphi on 22/01/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import Foundation

struct Position {
    let row: Int
    let column: Int
}

enum Cell {
    case empty(Position)
    case occupied(Position, Ball)       //  with a Ball
}

struct Ball {
    /// Coordinates of the ball in the matrix
    var position: Position
    var isBig: Bool = false // Making them always small when they appear.
    let colorIndex: Int     // Color cannot change during the game
    private static let colors: [Int] = Array(0..<7)     // Array for picking a random color index
    
    init(position: Position) {
        self.position = position
        colorIndex = Ball.colors.randomItem()!
    }
}

struct Board {
    /// The number of rows and of columns in the square board
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
        
    }
    
    mutating private func insertBalls() {
        //    for i in 0...2 {
        let positions: [Position] = emptyPositions
        let index: Int = Int.random(max: positions.count)
        let ball: Ball = Ball(position: positions[index])
        let position: Position = positions[index]
        let cell: Cell = Cell.occupied(position, ball)
        self[position] = cell
        //    }
    }
}

extension Board {
    subscript(position: Position) -> Cell {
        get { return matrix[position.row][position.column] }
        set { self.matrix[position.row][position.column] = newValue }
    }
    
    var emptyPositions: [Position] {
        return []
    }
    
    var occupiedPositions: [Position] {
        return []
    }
}

extension Cell {
    var position: Position {
        switch self {
        case .empty(let position), .occupied((let position), _):
            return (position)
        }
    }
    var ball: Ball? {
        switch self {
        case .empty(_): return nil
        case .occupied((_), let ball): return ball
        }
    }
}
