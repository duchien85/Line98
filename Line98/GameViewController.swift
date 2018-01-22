//
//  GameViewController.swift
//  Line98
//
//  Created by Glaphi on 20/01/2018.
//  Copyright © 2018 Glaphi. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    let boardView: BoardView = BoardView()
    //    var boardViewFrame: CGRect {  }

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        view.addSubview(buttonPrintMoves)
        view.addSubview(boardView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let x: CGFloat = 10
        let y: CGFloat = 50
        let width: CGFloat = (view.bounds.width<view.bounds.height) ? (view.bounds.width - 2*x) : view.bounds.height - 2*x
        let height: CGFloat = width
        boardView.frame = CGRect(x: x, y: y, width: width, height: height)
        boardView.center = view.center
        
        buttonPrintMoves.frame = CGRect(x: view.center.x, y: view.bounds.height - 50, width: 50, height: 50)

    }
}
