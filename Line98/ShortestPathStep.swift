//
//  ShortestPathStep.swift
//  Line98
//
//  Created by Glaphi on 08/02/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import Foundation

/// A single step on the computed path; used by the A* pathfinding algorithm
class ShortestPathStep: Hashable, Equatable {
    let position: Position
    var parent: ShortestPathStep?
    
    var gScore = 0
    var hScore = 0
    var fScore: Int {
        return gScore + hScore
    }
    
    init(_ position: Position) {
        self.position = position
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(position.column.hashValue)
        hasher.combine(position.row.hashValue)
    }
    
    func setParent(_ parent: ShortestPathStep, withMoveCost moveCost: Int) {
        // The G score is equal to the parent G score + the cost to move from the parent to it
        self.parent = parent
        self.gScore = parent.gScore + moveCost
    }
}

func ==(lhs: ShortestPathStep, rhs: ShortestPathStep) -> Bool {
    return lhs.position == rhs.position
}

extension ShortestPathStep {
    var description: String {
        return "pos=\(position) g=\(gScore) h=\(hScore) f=\(fScore)"
    }
}
