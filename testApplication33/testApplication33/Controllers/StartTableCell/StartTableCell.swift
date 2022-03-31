//
//  StartTableCell.swift
//  testApplication33
//
//  Created by Анна Гранёва on 24.01.22.
//

import UIKit

protocol StartTableCellDelegate: AnyObject{
    func showSomething(pressedCellType: ViewController.CellType)
}

class StartTableCell: UITableViewCell {
    static let identifier = "kStartTableCell"
    weak var delegate: StartTableCellDelegate?
    private var currentPressedCellType: ViewController.CellType = .comeIn
    @IBOutlet private weak var button: UIButton!
    
    func setup(buttonType: ViewController.CellType){
        currentPressedCellType = buttonType
        switch buttonType{
        case .userName:
            button.setTitle( ViewController.currentEnterLogin.isEmpty ? buttonType.rawValue : ViewController.currentEnterLogin, for: .normal)
        case .password:
            if ViewController.currentEnterpassword.isEmpty{
                button.setTitle(buttonType.rawValue, for: .normal)
            } else{
                var title = ""
                for _ in 0...ViewController.currentEnterpassword.count - 1 {
                    title += "*"
                }
                button.setTitle(title, for: .normal)
            }
        default:
            button.setTitle(buttonType.rawValue, for: .normal)
        }
    }
    
    func showButton(){
        button.isHidden = false
    }
    
    func hideButton(){
        button.isHidden = true
    }
    
    @IBAction func typeButtonAction(_ sender: Any) {
        delegate?.showSomething(pressedCellType: currentPressedCellType)
        print(currentPressedCellType)
    }
}
