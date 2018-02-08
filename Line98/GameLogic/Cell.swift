//
//  GameModels.swift
//  Line98
//
//  Created by Glaphi on 22/01/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import Foundation

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
