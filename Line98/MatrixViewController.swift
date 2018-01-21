//
//  MatrixViewController.swift
//  Line98
//
//  Created by Glaphi on 20/01/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import UIKit

class MatrixViewController: UIViewController {
    
    typealias Position = (row: Int, column: Int)
    typealias Matrix = [[MatrixButton]]
    var counter: Int = 0
    
    var button: MatrixButton = {
        let button: MatrixButton = MatrixButton()
        button.addTarget(self, action: #selector(checkSelected(_:)), for: .touchUpInside)
        button.backgroundColor = .black
        return button
    }()
    
    @objc func checkSelected(_ sender: MatrixButton) {
        let matrix: Matrix = sender.paramethers["matrix"] as! Matrix
        for i in 0...9 {
            for j in 0...9 {
                let item = matrix[i][j]
                if item.state == .selected {
                    print("item in row \(i+1) column \(j+1) is selected")
                }
            }
        }
        print("-------------------")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .red
        view.addSubview(button)
        
        var matrix: Matrix = []
        let matrixSize: Int = 10
        let side: CGFloat = view.bounds.width / CGFloat(matrixSize+1)
        let gap: CGFloat = side / CGFloat(matrixSize+1)
        var offset: CGPoint = CGPoint(x: gap, y: 50)
        
        func makeMatrix() -> Matrix {
            var matrix: Matrix = []
            for row in 0...matrixSize-1 {
                matrix.append([MatrixButton]())
                for column in 0...matrixSize-1 {
                    let newItem: MatrixButton = MatrixButton(frame: CGRect(origin: offset, size: side.asSquareSize))
                    view.addSubview(newItem)
                    matrix[row].append(newItem)
                    offset = CGPoint(x: offset.x + side + gap, y: offset.y)
                }
                offset = CGPoint(x: offset.x - side * CGFloat(matrixSize+1) + gap, y: offset.y + side)
            }
            return matrix
        }
        
        matrix = makeMatrix()
        for i in 0...9 {
            for j in 0...9 {
                matrix[i][j].paramethers = ["matrix": matrix]
            }
        }
        button.frame = CGRect(x: view.center.x, y: side * CGFloat(matrixSize+2), width: side, height: side)
        button.paramethers = ["matrix": matrix]
        
    }
}

class MatrixButton: UIButton {
    var paramethers: Dictionary<String, Any>
    
    @objc func wasChosen(_ sender: MatrixButton)  {
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
        self.layer.cornerRadius = 55
        self.backgroundColor = UIColor.cyan
        self.addTarget(self, action: #selector(wasChosen(_:)), for: .touchUpInside)
    }
}

extension CGFloat {
    var asSquareSize: CGSize {
        return CGSize(width: self, height: self)
    }
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { (view) in
            self.addSubview(view)
        }
    }
}

