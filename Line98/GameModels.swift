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

struct Direction {
    let i: Int
    let j: Int
    static let row = Direction(i: 0, j: 1)
    static let column = Direction(i: 1, j: 0)
    static let diagonal = Direction(i: 1, j: 1)
    static let antidiagonal = Direction(i: 1, j: -1)
}

class Ball {
    /// Coordinates of the `ball` in the matrix
    var position: Position
    /// Only if true the ball will be interractive
    var isBig: Bool = false // Making them always small when they appear.
    /// Random number between 0 to 6 for later picking the color out of array
    let colorIndex: Int     // Color cannot change during the game
    private static let colors: [Int] = Array(0..<7)     // Array for picking a random color index
    
    init(position: Position) {
        self.position = position
        colorIndex = Ball.colors.randomItem()!
    }
}

enum Cell {
    case empty(Position)
    case occupied(Position, Ball)       //  with a Ball
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
    
    var colorIndex: Int? {
        switch self {
        case .empty(_): return nil
        case .occupied((_), let ball): return ball.colorIndex
        }
    }
}

extension Position {
    /// Next position using provided increments for row and column
    func next(rowIncrement: Int, columnIncrement: Int) -> Position {
        return Position(row: self.row + rowIncrement, column: self.column + columnIncrement)
    }
    
}
