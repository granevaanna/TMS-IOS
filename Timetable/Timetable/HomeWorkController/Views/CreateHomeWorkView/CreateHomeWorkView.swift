//
//  CreateHomeWorkView.swift
//  Timetable
//
//  Created by Анна Гранёва on 23.04.22.
//

import UIKit

protocol CreateHomeWorkViewDelegate: AnyObject{
    func hideCreateHomeWorkView()
    func addHomeWorkToDataSource(homeWork: HomeWorkModel)
}

class CreateHomeWorkView: UIView{
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var textFields: [UITextField]!
    
    weak var delegate: CreateHomeWorkViewDelegate?
    
    private enum TextFieldsType: Int{
        case deadline = 1
        case lessonName = 2
        case homeWork = 3
    }
    
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
            contentView.layer.cornerRadius = 20
        }
    
    private func clearAllTextFields(){
        textFields.compactMap({ $0.text = "" })
    }
    
    @IBAction private func saveButtonAction(_ sender: Any) {
        var homeWorkModel = HomeWorkModel()
        homeWorkModel.deadline = textFields.first(where: { $0.tag == TextFieldsType.deadline.rawValue })?.text ?? ""
        homeWorkModel.lessonName = textFields.first(where: { $0.tag == TextFieldsType.lessonName.rawValue })?.text ?? ""
        homeWorkModel.homeWork = textFields.first(where: { $0.tag == TextFieldsType.homeWork.rawValue })?.text ?? ""
        
        delegate?.addHomeWorkToDataSource(homeWork: homeWorkModel)
        delegate?.hideCreateHomeWorkView()
        clearAllTextFields()
    }
    
    @IBAction private func cancelButtonAction(_ sender: Any) {
        delegate?.hideCreateHomeWorkView()
        clearAllTextFields()
    }
}
