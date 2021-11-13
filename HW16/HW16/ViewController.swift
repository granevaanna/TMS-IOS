//
//  ViewController.swift
//  HW16
//
//  Created by Анна Гранёва on 13.11.21.
//

import UIKit

class ViewController: UIViewController {
    
    var viewArray: [UIView] = []
    let numberOfViews = 4
    let numberOfPointsToJump: CGFloat = 50

    override func viewDidLoad() {
        super.viewDidLoad()
        let maxWidthOfBall = view.frame.width / 2
        let minWidthOfBall: Double = 50
        
        for i in 0...numberOfViews - 1 {
            let width = Double.random(in: minWidthOfBall...maxWidthOfBall)
            let positionX = Double.random(in: 0...view.frame.width - width)
            let positionY = Double.random(in: 0...view.frame.height - width)
            
            viewArray.append(UIView(frame: CGRect(x: positionX, y: positionY, width: width, height: width)))
            viewArray[i].backgroundColor = UIColor(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), alpha: 1)
            viewArray[i].layer.cornerRadius = viewArray[i].frame.width / 2
            view.addSubview(viewArray[i])
        }
        
//        for i in 0...numberOfViews - 1 {
//        let tapGesture = UITapGestureRecognizer(target: self,
//                                                action: #selector(jumpViewOnClick(index: i)))
//
//        tapGesture.cancelsTouchesInView = false
//        viewArray[i].addGestureRecognizer(tapGesture)
//        }
        
        let tapGestureFirst = UITapGestureRecognizer(target: self,
                                                action: #selector(jumpFirstViewOnClick))
        tapGestureFirst.cancelsTouchesInView = false
        viewArray[0].addGestureRecognizer(tapGestureFirst)
        
        
        
        let tapGestureSecond = UITapGestureRecognizer(target: self,
                                                action: #selector(jumpSecondViewOnClick))
        tapGestureSecond.cancelsTouchesInView = false
        viewArray[1].addGestureRecognizer(tapGestureSecond)
        
        
        let tapGestureThird = UITapGestureRecognizer(target: self,
                                                action: #selector(jumpThirdViewOnClick))
        tapGestureThird.cancelsTouchesInView = false
        viewArray[2].addGestureRecognizer(tapGestureThird)

        let tapGestureFouth = UITapGestureRecognizer(target: self,
                                                action: #selector(jumpFouthViewOnClick))
        tapGestureFouth.cancelsTouchesInView = false
        viewArray[3].addGestureRecognizer(tapGestureFouth)
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
    
    
//    @objc func jumpViewOnClick(index: Int) {
//        if viewArray[index].frame.origin.y - numberOfPointsToJump > 0 {
//             viewArray[index].frame.origin.y = viewArray[index].frame.origin.y - numberOfPointsToJump
//        } else {
//            viewArray[index].frame.origin.y = 0
//        }
//    }
    
    @objc func jumpFirstViewOnClick() {
       if viewArray[0].frame.origin.y - numberOfPointsToJump > 0 {
            viewArray[0].frame.origin.y = viewArray[0].frame.origin.y - numberOfPointsToJump
       } else {
           viewArray[0].frame.origin.y = 0
       }
    }
    @objc func jumpSecondViewOnClick() {
        if viewArray[1].frame.origin.y - numberOfPointsToJump > 0 {
             viewArray[1].frame.origin.y = viewArray[1].frame.origin.y - numberOfPointsToJump
        } else {
            viewArray[1].frame.origin.y = 0
        }
    }
    @objc func jumpThirdViewOnClick() {
        if viewArray[2].frame.origin.y - numberOfPointsToJump > 0 {
             viewArray[2].frame.origin.y = viewArray[2].frame.origin.y - numberOfPointsToJump
        } else {
            viewArray[2].frame.origin.y = 0
        }
    }
    @objc func jumpFouthViewOnClick() {
        if viewArray[3].frame.origin.y - numberOfPointsToJump > 0 {
             viewArray[3].frame.origin.y = viewArray[3].frame.origin.y - numberOfPointsToJump
        } else {
            viewArray[3].frame.origin.y = 0
        }
    }

}

