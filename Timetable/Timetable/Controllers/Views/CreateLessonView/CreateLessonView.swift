//
//  CreateLessonView.swift
//  Timetable
//
//  Created by Анна Гранёва on 18.02.22.
//

import UIKit

protocol CreateLessonViewDelegate: AnyObject{
    func hideCreateLessonView()
    func changedUpHideConstraint()
    func changedDownHideConstraint()
    func addCurrentLesson(lesson: LessonModel, index: Int)
}

final class CreateLessonView: UIView{
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var textFields: [UITextField]!
    
    private let viewController = ViewController()
    private var timePicker = UIDatePicker()
    
    weak var delegate: CreateLessonViewDelegate?
    private var currentLessonModel: LessonModel = LessonModel(lessonName: "", teacher: "", audience: "", startTime: "", endTime: "")
    private var tagOfSelectedTextField: Int = 0

    private enum TextFieldsType: Int{
        case lessonName = 0
        case teacher = 1
        case audience = 2
        case startTime = 3
        case endTime = 4
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
            contentView.backgroundColor = .mainColor
            contentView.layer.cornerRadius = 20
            setupDatePicker()
        }
    
    @IBAction func textFieldsAction(_ sender: UITextField) {
        tagOfSelectedTextField = sender.tag
        delegate?.changedUpHideConstraint()
    }
    
    @IBAction private func cancelButtonAction(_ sender: Any) {
        endEditing(true)
        delegate?.hideCreateLessonView()
        delegate?.changedDownHideConstraint()
        textFields.compactMap({ $0.text = "" })
    }
    
    @IBAction private func saveButtonAction(_ sender: Any) {
        currentLessonModel.lessonName = textFields.first(where: { $0.tag == TextFieldsType.lessonName.rawValue })?.text ?? "-"
        currentLessonModel.teacher = textFields.first(where: { $0.tag == TextFieldsType.teacher.rawValue })?.text ?? "-"
        currentLessonModel.audience = textFields.first(where: { $0.tag == TextFieldsType.audience.rawValue })?.text ?? "-"
        currentLessonModel.startTime = textFields.first(where: { $0.tag == TextFieldsType.startTime.rawValue })?.text ?? "-"
        currentLessonModel.endTime = textFields.first(where: { $0.tag == TextFieldsType.endTime.rawValue })?.text ?? "-"
        
        delegate?.addCurrentLesson(lesson: currentLessonModel, index: 0)
        
        endEditing(true)
        delegate?.hideCreateLessonView()
        delegate?.changedDownHideConstraint()
        textFields.compactMap({ $0.text = "" })
    }
}


//MARK: - TimePicker
extension CreateLessonView{
    func setupDatePicker() {
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        
        textFields.first(where: { $0.tag == TextFieldsType.startTime.rawValue })?.inputAccessoryView = createdToolbar()
        textFields.first(where: { $0.tag == TextFieldsType.startTime.rawValue })?.inputView = timePicker
        
        textFields.first(where: { $0.tag == TextFieldsType.endTime.rawValue })?.inputAccessoryView = createdToolbar()
        textFields.first(where: { $0.tag == TextFieldsType.endTime.rawValue })?.inputView = timePicker
    }
    
    func createdToolbar() -> UIToolbar{
        let toolbar = UIToolbar();
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePickerAction))

        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPickerAction))

        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        textFields.first(where: { $0.tag == TextFieldsType.startTime.rawValue })?.inputAccessoryView = toolbar
        textFields.first(where: { $0.tag == TextFieldsType.startTime.rawValue })?.inputView = timePicker
        
        
        textFields.first(where: { $0.tag == TextFieldsType.endTime.rawValue })?.inputAccessoryView = toolbar
        textFields.first(where: { $0.tag == TextFieldsType.endTime.rawValue })?.inputView = timePicker

        return toolbar
    }
    
    @objc func donePickerAction() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:MM"
        textFields.first(where: { $0.tag == tagOfSelectedTextField })?.text = formatter.string(from: timePicker.date)
        endEditing(true)
    }
    
    @objc func cancelPickerAction(){
        delegate?.changedDownHideConstraint()
        endEditing(true)
    }
}
