//
//  CellButton.swift
//  Line98
//
//  Created by Glaphi on 22/01/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import UIKit

class CellButton: UIButton {
    
    private(set) var position: Position!
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public required init(position: Position, frame: CGRect? = nil) {
        super.init(frame: frame ?? .zero)
        self.position = position
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
    }
}


class BallView: UIView {
    var ball: Ball! // Must have a ball

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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = bounds.width / 2
        self.clipsToBounds = true
        self.backgroundColor = UIColor.blue
    }
    
}
