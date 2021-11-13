//
//  ViewController.swift
//  HW16
//
//  Created by Анна Гранёва on 13.11.21.
//

import UIKit

class ViewController: UIViewController {
    
    var viewArray: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let maxWidthOfBall = view.frame.width / 2
        let minWidthOfBall: Double = 50
        
        for i in 0...3 {
            let width = Double.random(in: minWidthOfBall...maxWidthOfBall)
            let positionX = Double.random(in: 0...view.frame.width - width)
            let positionY = Double.random(in: 0...view.frame.height - width)
            
            viewArray.append(UIView(frame: CGRect(x: positionX, y: positionY, width: width, height: width)))
            viewArray[i].backgroundColor = UIColor(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), alpha: 1)
            viewArray[i].layer.cornerRadius = viewArray[i].frame.width / 2
            view.addSubview(viewArray[i])
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 2){
            for i in 0...self.viewArray.count - 1 {
                self.viewArray[i].frame.origin.y = self.view.frame.height - self.viewArray[i].frame.height
                self.view.layoutSubviews()
            }
        }
    }
}

