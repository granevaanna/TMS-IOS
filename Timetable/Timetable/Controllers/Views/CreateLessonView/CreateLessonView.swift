//
//  CreateLessonView.swift
//  Timetable
//
//  Created by Анна Гранёва on 18.02.22.
//

import UIKit

enum CreateLessonViewType{
    case add
    case adit
}

protocol CreateLessonViewDelegate: AnyObject{
    func hideCreateLessonView()
    func changedUpHideConstraint()
    func changedDownHideConstraint()
    func addCurrentLesson(lesson: LessonModel)
    func aditCurrentLesson(lesson: LessonModel)
}

final class CreateLessonView: UIView{
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var textFields: [UITextField]!
    
    private let viewController = ViewController()
    private var timePicker = UIDatePicker()
    
    weak var delegate: CreateLessonViewDelegate?
    private var tagOfSelectedTextField: Int = 0
    
    private var createLessonViewType: CreateLessonViewType = .add

    private enum TextFieldsType: Int{
        case lessonName = 0
        case teacher = 1
        case audience = 2
        case startTime = 3
        case endTime = 4
        case lessonType = 5
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
    
    @IBAction private func textFieldsAction(_ sender: UITextField) {
        tagOfSelectedTextField = sender.tag
        delegate?.changedUpHideConstraint()
    }
    
    @IBAction private func cancelButtonAction(_ sender: Any) {
        endEditing(true)
        delegate?.hideCreateLessonView()
        delegate?.changedDownHideConstraint()
        textFields.compactMap({ $0.text = "" })
        textFields.first(where: { $0.tag == TextFieldsType.lessonName.rawValue })?.layer.borderWidth = 0
        textFields.first(where: { $0.tag == TextFieldsType.lessonName.rawValue })?.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    @IBAction private func saveButtonAction(_ sender: Any) {
        if let lessonText = textFields.first(where: { $0.tag == TextFieldsType.lessonName.rawValue })?.text, lessonText.isEmpty {
            textFields.first(where: { $0.tag == TextFieldsType.lessonName.rawValue })?.layer.borderWidth = 2
            textFields.first(where: { $0.tag == TextFieldsType.lessonName.rawValue })?.layer.borderColor = .init(red: 1, green: 0, blue: 0, alpha: 1)
        } else {
            var currentLessonModel = LessonModel()
            
            currentLessonModel.lessonName = textFields.first(where: { $0.tag == TextFieldsType.lessonName.rawValue })?.text ?? "-"
            currentLessonModel.teacher = textFields.first(where: { $0.tag == TextFieldsType.teacher.rawValue })?.text ?? "-"
            currentLessonModel.audience = textFields.first(where: { $0.tag == TextFieldsType.audience.rawValue })?.text ?? "-"
            currentLessonModel.startTime = textFields.first(where: { $0.tag == TextFieldsType.startTime.rawValue })?.text ?? "-"
            currentLessonModel.endTime = textFields.first(where: { $0.tag == TextFieldsType.endTime.rawValue })?.text ?? "-"
            currentLessonModel.lessonType = textFields.first(where: { $0.tag == TextFieldsType.lessonType.rawValue })?.text ?? "-"
            
            switch createLessonViewType {
            case .add:
                delegate?.addCurrentLesson(lesson: currentLessonModel)
            case .adit:
                delegate?.aditCurrentLesson(lesson: currentLessonModel)
            }
            
            endEditing(true)
            delegate?.hideCreateLessonView()
            delegate?.changedDownHideConstraint()
            textFields.compactMap({ $0.text = "" })
            textFields.first(where: { $0.tag == TextFieldsType.lessonName.rawValue })?.layer.borderWidth = 0
            textFields.first(where: { $0.tag == TextFieldsType.lessonName.rawValue })?.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    func setToTextFields(with lessonModel: LessonModel){
        textFields.first(where: { $0.tag == TextFieldsType.lessonName.rawValue })?.text = lessonModel.lessonName
        textFields.first(where: { $0.tag == TextFieldsType.teacher.rawValue })?.text = lessonModel.teacher
        textFields.first(where: { $0.tag == TextFieldsType.audience.rawValue })?.text = lessonModel.audience
        textFields.first(where: { $0.tag == TextFieldsType.startTime.rawValue })?.text = lessonModel.startTime
        textFields.first(where: { $0.tag == TextFieldsType.endTime.rawValue })?.text = lessonModel.endTime
    }
    
    func changeCreateLessonViewType(createLessonViewType: CreateLessonViewType){
        self.createLessonViewType = createLessonViewType
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
        formatter.dateFormat = "HH:mm"
        textFields.first(where: { $0.tag == tagOfSelectedTextField })?.text = formatter.string(from: timePicker.date)
        endEditing(true)
    }
    
    @objc func cancelPickerAction(){
        delegate?.changedDownHideConstraint()
        endEditing(true)
    }
}
