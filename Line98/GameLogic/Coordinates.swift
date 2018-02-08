//
//  GameModels.swift
//  Line98
//
//  Created by Glaphi on 08/02/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import Foundation

struct Position: Equatable {
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

extension Position {
    /// Next position using provided increments for row and column
    func next(rowIncrement: Int, columnIncrement: Int) -> Position {
        return Position(row: self.row + rowIncrement, column: self.column + columnIncrement)
    }
    
    var top: Position { return next(rowIncrement: -1, columnIncrement: 0)}
    var bottom: Position { return next(rowIncrement: 1, columnIncrement: 0) }
    var left: Position { return next(rowIncrement: 0, columnIncrement: -1)}
    var right: Position { return next(rowIncrement: 0, columnIncrement: 1)}
    
    static func ==(lhs: Position, rhs: Position) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column
    }
}

