//
//  File.swift
//  Line98
//
//  Created by Glaphi on 22/01/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import UIKit

//------------------------------------------------------------------------------------------------//
// Cell View

typealias Matrix = [[MatrixCellButton]]

class MatrixCellButton: UIButton {
    
    var paramethers: Dictionary<String, Any>
    
    @objc func changeHeart(_ sender: MatrixCellButton)  {
        sender.isSelected = (sender.isSelected == true) ? false : true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.paramethers = [:]
        super.init(coder: aDecoder)
    }
    
    public override required init(frame: CGRect) {
        self.paramethers = [:]
        super.init(frame: frame)
        
        self.tag = -1
        self.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        self.setImage(#imageLiteral(resourceName: "heartFill"), for: .selected)
        self.backgroundColor = UIColor.cyan
        self.addTarget(self, action: #selector(changeHeart(_:)), for: .touchUpInside)
    }
}
