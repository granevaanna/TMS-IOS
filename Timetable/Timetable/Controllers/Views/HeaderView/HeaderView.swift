//
//  HeaderView.swift
//  Timetable
//
//  Created by Анна Гранёва on 16.02.22.
//

import UIKit

protocol HeaderViewDelegate: AnyObject{
    func showSettingView()
}

final class HeaderView: UIView{
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var settingButton: UIButton!
    
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
    
    func disableSettingButton(){
        settingButton.isEnabled = false
    }
    
    func enabledSettingButton(){
        settingButton.isEnabled = true
    }
    
    @IBAction private func settingButtonAction(_ sender: Any) {
        delegate?.showSettingView()
    }
}
