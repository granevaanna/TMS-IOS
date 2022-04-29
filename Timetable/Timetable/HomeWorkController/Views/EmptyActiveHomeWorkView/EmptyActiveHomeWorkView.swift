//
//  EmptyActiveHomeWorkView.swift
//  Timetable
//
//  Created by Анна Гранёва on 29.04.22.
//

import UIKit

final class EmptyActiveHomeWorkView: UIView{
    @IBOutlet private var contentView: UIView!

    override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        
        private func commonInit() {
            Bundle.main.loadNibNamed("\(type(of: self))", owner: self, options: nil)
            addSubview(contentView)
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
}
