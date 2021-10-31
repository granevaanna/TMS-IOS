//
//  AddStudentScreen.swift
//  InformationAboutStudents
//
//  Created by Анна Гранёва on 30.10.21.
//

import UIKit

final class AddStudentScreen: UIViewController{
    
    var student = StudentModel(nameString: "", markString: 0, groupString: 1)
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var markTextField: UITextField!
    @IBOutlet private weak var groupTextField: UITextField!
    
    @IBOutlet private weak var cancelButton: UIBarButtonItem!
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
    }
    
    func updateSaveButtonState(){
        
        var flag = true
        
        if let name = nameTextField.text,
           let markText = markTextField.text,
           let mark = Double(markText),
           let groupText = groupTextField.text,
           let group = Double(groupText),
           mark >= 0 && mark <= 10,
           group >= 1 && group <= 10{
            flag = true
        }else{
            flag = false
        }
        
        saveButton.isEnabled = flag
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else {return}
        
        
        if let name = nameTextField.text,
           let markText = markTextField.text,
           let mark = Double(markText),
           let groupText = groupTextField.text,
           let group = Double(groupText),
           mark >= 0 && mark <= 10,
           group >= 1 && group <= 10{
            self.student = StudentModel(nameString: name, markString: mark, groupString: Int(group))
        }
    }
}
