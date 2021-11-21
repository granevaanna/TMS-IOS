//
//  ViewController.swift
//  noughtsAndCrosses
//
//  Created by Анна Гранёва on 21.11.21.
//

import UIKit

class ViewController: UIViewController {
    
    let crossImage = UIImage(named: "cross")
    let noughtImage = UIImage(named: "nought")

    @IBOutlet weak var gameView: GameView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

