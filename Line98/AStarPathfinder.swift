//
//  AStarPathfinder.swift
//  Line98
//
//  Created by Glaphi on 08/02/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import Foundation

/// A pathfinder based on the A* algorithm to find the shortest path between two locations
class AStarPathfinder {
    
    func hScoreFrom(_ origin: Position, to destination: Position) -> Int {
        return abs(destination.column - origin.column) + abs(destination.row - origin.row)
    }
    
    private func insert(_ step: ShortestPathStep, in openSteps: inout [ShortestPathStep]) {
        openSteps.append(step)
        openSteps.sort { $0.fScore <= $1.fScore }
    }
    
    private func positionsConvertedFromSteps(to step: ShortestPathStep) -> [Position] {
        var path: [Position] = []
        var currentStep: ShortestPathStep = step
        while let parent = currentStep.parent { // if parent is nil, then it is our starting step, so don't include it
            path.insert(currentStep.position, at: 0)
            currentStep = parent
        }
        return path
    }
    
    func shortestPath(in emptyPositions: [Position], from origin: Position, to destination: Position) -> [Position]? {
        
        var closedSteps = Set<ShortestPathStep>()
        var openSteps: [ShortestPathStep] = [ShortestPathStep(origin)]
        
        while !openSteps.isEmpty {
            let currentStep = openSteps.remove(at: 0)
            closedSteps.insert(currentStep)
            
            if currentStep.position == destination {
                return positionsConvertedFromSteps(to: currentStep)
            }
            
            let neighbors: [Position] = walkableAdjacentPositions(in: emptyPositions, around: currentStep.position)
            for pos in neighbors {
                let step: ShortestPathStep = ShortestPathStep(pos)
                if closedSteps.contains(step) { continue }
                let moveCost = costToMove(from: currentStep.position, to: step.position)
                
                if let existingIndex: Int = openSteps.index(of: step) {
                    let step = openSteps[existingIndex]
                    if currentStep.gScore + moveCost < step.gScore {
                        step.setParent(currentStep, withMoveCost: moveCost)
                        
                        openSteps.remove(at: existingIndex)
                        insert(step, in: &openSteps)
                    }
                } else {
                    step.setParent(currentStep, withMoveCost: moveCost)
                    step.hScore = hScoreFrom(step.position, to: destination)
                    insert(step, in: &openSteps)
                }
            }
        }
        return nil
    }
}

// NOTE FOR MYSELF
// These functions were previously implemented in Board thought PathFinderDataSource protocol
// And the AStarPathFinder constantly asked the board to calculate and provide this information
// On each step. But this bad decision: board as the main class should be independant.
// Except maybe the cost should be sent as a parameter too.
// But in this game the cost is always the same so it doesnt matter
extension AStarPathfinder {
    
    func walkableAdjacentPositions(in emptyPositions: [Position], around position: Position) -> [Position] {
        var neighbors: [Position] = [position.top, position.bottom, position.left, position.right]
        neighbors = neighbors.filter({ (pos) -> Bool in
            emptyPositions.contains(pos)
        })
        return neighbors
    }
    
    func costToMove(from position: Position, to neighborPosition: Position) -> Int {
        return 1
    }
}
