//
//  Extensions.swift
//  TMS29
//
//  Created by lion on 14.01.22.
//

import Foundation
import UIKit

extension UIView {
    
  
    //MARK: - extension. Custom Corners
    func addRoundCorners(corners: [UIRectCorner], cornerRadius: CGFloat) {
            
            var _corners: UIRectCorner = []
            
            corners.forEach { (corner) in
                _corners.update(with: corner)
            }
        
            let maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath(roundedRect: self.bounds,
                                          byRoundingCorners: _corners,
                                          cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
            self.layer.mask = maskLayer
        }
    
    
    //MARK: - extension. Custom separator
//    func addSeparatorLine(color: UIColor, leading: Int, trailing: Int){
//        let line = UIView()
//        addSubview(line)
//        line.snp.makeConstraints { make in
//            make.height.equalTo(1)
//            make.bottom.equalToSuperview()
//            make.leading.equalToSuperview().inset(leading)
//            make.trailing.equalToSuperview().inset(trailing)
//        }
//        line.backgroundColor = color
//
//    }
    //MARK: - extension. Custom Shadow
    func setShadow(color: UIColor = .gray, opacity: Float = 0.5, offSet: CGSize = .zero, radius: CGFloat = 15) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
    
   
    
}


