//
//  AStarPathfinder.swift
//  Line98
//
//  Created by Glaphi on 08/02/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import Foundation

protocol PathFinderDataSource {
    func walkableAdjacentPositions(for position: Position) -> [Position]
    func costToMove(from position: Position, to neighborPosition: Position) -> Int
}

/// A pathfinder based on the A* algorithm to find the shortest path between two locations
class AStarPathfinder {
    var dataSource: PathFinderDataSource?
    
    private func insert(_ step: ShortestPathStep, in openSteps: inout [ShortestPathStep]) {
        openSteps.append(step)
        openSteps.sort { $0.fScore <= $1.fScore }
    }
    
    func hScoreFrom(_ origin: Position, to destination: Position) -> Int {
        return abs(destination.column - origin.column) + abs(destination.row - origin.row)
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
                print("Path Found")
                var step: ShortestPathStep? = currentStep
                while step != nil {
                    print(step!.description) // printing in reverse
                    step = step!.parent
                }
                return []
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
