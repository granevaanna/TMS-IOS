//
//  CreateHomeWorkView.swift
//  Timetable
//
//  Created by Анна Гранёва on 23.04.22.
//

import UIKit

protocol CreateHomeWorkViewDelegate: AnyObject{
    func hideCreateHomeWorkView()
    func addHomeWorkToActiveHomeworks(homeWork: HomeWorkModel)
    func aditHomeWork(newHomeWork: HomeWorkModel)
    func changedUpHideConstraint()
    func changedDownHideConstraint()
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
    
    private var createHomeWorkViewType: CreateLessonViewType = .add
//    private var selectedHomeWorkIndex: Int?
//    private var selectedHomeWork: HomeWorkModel?
    
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
    
    func changeCreateHomeWorkViewType(createHomeWorkViewType: CreateLessonViewType){
        self.createHomeWorkViewType = createHomeWorkViewType
    }
    
    func setToTextFields(homeWork: HomeWorkModel){
        textFields.first(where: { $0.tag == TextFieldsType.deadline.rawValue })?.text = homeWork.deadline
        textFields.first(where: { $0.tag == TextFieldsType.lessonName.rawValue })?.text = homeWork.lessonName
        textFields.first(where: { $0.tag == TextFieldsType.homeWork.rawValue
        })?.text = homeWork.homeWork
    }
    
    @IBAction func textFieldsAction(_ sender: UITextField) {
        delegate?.changedUpHideConstraint()
        sender.layer.borderWidth = 0
    }
    
    
    
    @IBAction private func saveButtonAction(_ sender: Any) {
        guard let deadline = textFields.first(where: { $0.tag == TextFieldsType.deadline.rawValue })?.text,
              let lessonName = textFields.first(where: { $0.tag == TextFieldsType.lessonName.rawValue })?.text,
              let homeWork = textFields.first(where: { $0.tag == TextFieldsType.homeWork.rawValue })?.text
        else { return }
        
        guard !deadline.isEmpty, !lessonName.isEmpty, !homeWork.isEmpty else {
            if deadline.isEmpty{
                textFields.first(where: { $0.tag == TextFieldsType.deadline.rawValue })?.layer.borderWidth = 2
                textFields.first(where: { $0.tag == TextFieldsType.deadline.rawValue })?.layer.borderColor = .init(red: 1, green: 0, blue: 0, alpha: 1)
            }
            if lessonName.isEmpty{
                textFields.first(where: { $0.tag == TextFieldsType.lessonName.rawValue })?.layer.borderWidth = 2
                textFields.first(where: { $0.tag == TextFieldsType.lessonName.rawValue })?.layer.borderColor = .init(red: 1, green: 0, blue: 0, alpha: 1)
            }
            if homeWork.isEmpty{
                textFields.first(where: { $0.tag == TextFieldsType.homeWork.rawValue })?.layer.borderWidth = 2
                textFields.first(where: { $0.tag == TextFieldsType.homeWork.rawValue })?.layer.borderColor = .init(red: 1, green: 0, blue: 0, alpha: 1)
            }
            return
        }
        
        let homeWorkModel = HomeWorkModel(deadline:deadline, lessonName: lessonName, homeWork: homeWork)
        
        switch createHomeWorkViewType {
        case .add:
            delegate?.addHomeWorkToActiveHomeworks(homeWork: homeWorkModel)
        case .adit:
            delegate?.aditHomeWork(newHomeWork: homeWorkModel)
        }
        
        textFields.compactMap({ $0.layer.borderWidth = 0 })
        endEditing(true)
        delegate?.hideCreateHomeWorkView()
        clearAllTextFields()
        delegate?.changedDownHideConstraint()
    }
    
    @IBAction private func cancelButtonAction(_ sender: Any) {
        endEditing(true)
        textFields.compactMap({ $0.layer.borderWidth = 0 })
        delegate?.hideCreateHomeWorkView()
        clearAllTextFields()
        delegate?.changedDownHideConstraint()
    }
}
