//
//  EmptyLessonsView.swift
//  Timetable
//
//  Created by Анна Гранёва on 3.03.22.
//

import UIKit

final class EmptyLessonsView: UIView{
    @IBOutlet private var contentView: UIView!
    private var pressedFlag = false
    weak var delegate: HeaderViewDelegate?

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
