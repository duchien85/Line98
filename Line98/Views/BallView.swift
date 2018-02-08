//
//  BallView.swift
//  Line98
//
//  Created by Glaphi on 22/01/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import UIKit

class BallView: UIView {
    var ball: Ball! // Must have a ball
    
    /// Returns the coordinates of the `ball` in the matrix
    var position: Position {
        return ball.position
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required init(_ ball: Ball, frame: CGRect? = nil) {
        super.init(frame: frame ?? .zero)
        self.ball = ball
        self.isUserInteractionEnabled = false
        self.backgroundColor = BallView.colors[ball.colorIndex]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = bounds.width / 2
        self.clipsToBounds = true
    }
    
    /// The array of 7 available color for the `ball views`
    static var colors: [UIColor] = [.red, .black, .blue, .brown, .green, .cyan, .magenta]
}
