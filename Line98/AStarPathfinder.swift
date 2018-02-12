//
//  AStarPathfinder.swift
//  Line98
//
//  Created by Glaphi on 08/02/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import Foundation

// AnyObject for class
protocol PathFinderDataSource: AnyObject {
    func walkableAdjacentPositions(for position: Position) -> [Position]
    func costToMove(from position: Position, to neighborPosition: Position) -> Int
}

/// A pathfinder based on the A* algorithm to find the shortest path between two locations
class AStarPathfinder {
    weak var dataSource: PathFinderDataSource?
    
    private func insert(_ step: ShortestPathStep, in openSteps: inout [ShortestPathStep]) {
        openSteps.append(step)
        openSteps.sort { $0.fScore <= $1.fScore }
    }
    
    func hScoreFrom(_ origin: Position, to destination: Position) -> Int {
        return abs(destination.column - origin.column) + abs(destination.row - origin.row)
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
    
    func shortestPath(from origin: Position, to destination: Position) -> [Position]? {
        // placeholder: move immediately to the destination coordinate
        if self.dataSource == nil { return nil }
        let dataSource: PathFinderDataSource = self.dataSource!
        
        var closedSteps = Set<ShortestPathStep>()
        var openSteps: [ShortestPathStep] = [ShortestPathStep(origin)]
        
        while !openSteps.isEmpty {
            let currentStep = openSteps.remove(at: 0)
            closedSteps.insert(currentStep)
            
            if currentStep.position == destination {
                return positionsConvertedFromSteps(to: currentStep)
            }
            
            let neighbors: [Position] = dataSource.walkableAdjacentPositions(for: currentStep.position)
            for pos in neighbors {
                let step: ShortestPathStep = ShortestPathStep(pos)
                if closedSteps.contains(step) { continue }
                let moveCost = dataSource.costToMove(from: currentStep.position, to: step.position)
                
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
