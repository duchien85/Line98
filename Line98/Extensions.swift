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

public extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { (view) in
            self.addSubview(view)
        }
    }
}

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

public extension UIColor {
    
    static var softLigthBlue: UIColor {
        get { return UIColor(red: 0.65, green: 0.84, blue: 0.96, alpha: 1.0) }
    }
    
    static var softYellow: UIColor {
        get { return UIColor(red: 0.97, green: 0.95, blue: 0.72, alpha: 1.0) }
    }
    
    static var softViolet: UIColor {
        get { return UIColor(red: 0.85, green: 0.80, blue: 0.98, alpha: 1.0) }
    }
    
    static var softPurple: UIColor {
        get { return UIColor(red: 0.85, green: 0.77, blue: 0.96, alpha: 1.0) }
    }
    
    static var softOrange: UIColor {
        get { return UIColor(red: 0.98, green: 0.78, blue: 0.70, alpha: 1.0) }
    }
    
    static var softAquamarine: UIColor {
        get { return UIColor(red: 0.65, green: 0.95, blue: 0.95, alpha: 1.0) }
    }
    
    static var softLightGreen: UIColor {
        get { return UIColor(red: 0.79, green: 0.94, blue: 0.73, alpha: 1.0) }
    }
    
    static var softRed: UIColor {
        get { return UIColor(red: 0.97, green: 0.72, blue: 0.72, alpha: 1.0) }
    }
    
    static var softGray: UIColor {
        get { return UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0) }
    }
    
    static var softLightGray97: UIColor {
        get { return UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0) }
    }
}
