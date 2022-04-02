//
//  ViewController.swift
//  HW16
//
//  Created by Анна Гранёва on 13.11.21.
//

import UIKit


final class RoundedView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ViewController: UIViewController {
    
    var viewArray: [RoundedView] = []
    let numberOfViews = 4
    let numberOfPointsToJump: CGFloat = 50

    override func viewDidLoad() {
        super.viewDidLoad()
        let maxWidthOfBall = view.frame.width / 2
        let minWidthOfBall: Double = 50
        
        let tapGestureFirst = UITapGestureRecognizer(target: self,
                                                action: #selector(jumpFirstViewOnClick(_:)))
        view.addGestureRecognizer(tapGestureFirst)
        
        for i in 0...numberOfViews - 1 {
            let width = Double.random(in: minWidthOfBall...maxWidthOfBall)
            let positionX = Double.random(in: 0...view.frame.width - width)
            let positionY = Double.random(in: 0...view.frame.height - width)
            
            viewArray.append(RoundedView(frame: CGRect(x: positionX, y: positionY, width: width, height: width)))
            viewArray[i].backgroundColor = UIColor(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), alpha: 1)
            viewArray[i].layer.cornerRadius = viewArray[i].frame.width / 2
            view.addSubview(viewArray[i])
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 2) {
            for i in 0...self.viewArray.count - 1 {
                self.viewArray[i].frame.origin.y = self.view.frame.height - self.viewArray[i].frame.height
                self.view.layoutSubviews()
            }
        }
    }
    
    private func animateJumping(view: UIView) {
        UIView.animate(withDuration: 0.3) {
            view.frame.origin.y -= CGFloat.random(in: 50...300)
        } completion: { success in
            UIView.animate(withDuration: 2) {
                view.frame.origin.y = self.view.frame.height - view.frame.height
            }
        }
    }
    
    @objc private func jumpFirstViewOnClick(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: sender.view)
        if let view = sender.view?.hitTest(point, with: nil) as? RoundedView {
            animateJumping(view: view)
        }
    }
}
