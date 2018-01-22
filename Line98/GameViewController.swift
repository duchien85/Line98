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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        view.addSubview(boardView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let x: CGFloat = 10
        let width: CGFloat = (view.bounds.width<view.bounds.height) ? (view.bounds.width - 2*x) : view.bounds.height - 2*x
        let height: CGFloat = width
        boardView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        boardView.center = view.center
    }
}
