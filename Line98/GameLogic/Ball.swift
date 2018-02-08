//
//  Ball.swift
//  Line98
//
//  Created by Glaphi on 08/02/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import Foundation

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
