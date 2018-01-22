//
//  Extensions.swift
//  Line98
//
//  Created by Glaphi on 22/01/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import UIKit

public extension CGFloat {
    var asSquareSize: CGSize {
        return CGSize(width: self, height: self)
    }
}

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

extension Int {
    static func random(max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }
}

