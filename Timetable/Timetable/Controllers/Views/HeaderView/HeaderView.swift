//
//  HeaderView.swift
//  Timetable
//
//  Created by Анна Гранёва on 16.02.22.
//

import UIKit

protocol HeaderViewDelegate: AnyObject{
    func pressedSettingButton(pressedFlag: Bool)
}

final class HeaderView: UIView{
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
            contentView.backgroundColor = .mainColor
        }
    
    func changePressedFlag(flag: Bool){
        pressedFlag = flag
    }
    
    @IBAction private func settingButtonAction(_ sender: Any) {
        pressedFlag.toggle()
        delegate?.pressedSettingButton(pressedFlag: pressedFlag)
    }
}
