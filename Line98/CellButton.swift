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
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
    }
}
