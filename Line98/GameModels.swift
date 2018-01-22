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

class Ball {
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
