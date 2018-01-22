//
//  GameViewController.swift
//  Line98
//
//  Created by Glaphi on 20/01/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var matrix: Matrix = []
    var movesCounter: Int = 0 // How many moves
    
    var buttonPrintMoves: MatrixCellButton = {
        let button: MatrixCellButton = MatrixCellButton()
        button.addTarget(self, action: #selector(buttonTest(_:)), for: .touchUpInside)
        button.backgroundColor = .black
        return button
    }()
    
    @objc func buttonTest(_ sender: MatrixCellButton) {
        print(movesCounter)
    }
    
    @objc func wasChosen(_ sender: MatrixCellButton) {
        //let matrix: Matrix = sender.paramethers["matrix"] as! Matrix
        let pos: Position = sender.paramethers["position"] as! Position
        print(pos)
        movesCounter += 1 // Counts how many touches where made since the beggining
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .red
        view.addSubview(buttonPrintMoves)
        
        let matrixSize: Int = 3
        let side: CGFloat = view.bounds.width / CGFloat(matrixSize+1)
        let gap: CGFloat = side / CGFloat(matrixSize+1)
        var offset: CGPoint = CGPoint(x: gap, y: 50)
        
        // Setting frames and creating matrix
        func makeMatrix() -> Matrix {
            var matrix: Matrix = []
            for row in 0..<matrixSize {
                matrix.append([MatrixCellButton]())
                for _ in 0..<matrixSize { //column
                    let newItem: MatrixCellButton = MatrixCellButton(frame: CGRect(origin: offset, size: side.asSquareSize))
                    newItem.addTarget(self, action: #selector(wasChosen(_:)), for: .touchUpInside)
                    view.addSubview(newItem)
                    matrix[row].append(newItem)
                    offset = CGPoint(x: offset.x + side + gap, y: offset.y)
                }
                offset = CGPoint(x: offset.x - side * CGFloat(matrixSize+1) + gap, y: offset.y + side + gap)
            }
            return matrix
        }
        buttonPrintMoves.frame = CGRect(x: view.center.x, y: side * CGFloat(matrixSize+2), width: side, height: side)
        
        
        matrix = makeMatrix()
        
        // Adding passable paramethers
        for i in 0...matrix[0].count-1 {
            for j in 0...matrix[0].count-1 {
                let position: Position = Position(row: i, column: j)
                matrix[i][j].paramethers.updateValue(position, forKey: "position")
                matrix[i][j].paramethers.updateValue(matrix, forKey: "matrix")
            }
        }
        buttonPrintMoves.paramethers = ["matrix": matrix]
        
    }
}
