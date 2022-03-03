//
//  ViewController.swift
//  Timetable
//
//  Created by Анна Гранёва on 16.02.22.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var headerView: HeaderView!
    @IBOutlet private weak var daysOfTheWeekCollectionView: UICollectionView!
    @IBOutlet private weak var daysView: DaysView!
    @IBOutlet private weak var createLessonView: CreateLessonView!
    @IBOutlet private weak var selectedLessonView: SelectedLessonView!
    @IBOutlet private weak var settingView: SettingView!
    
    
    @IBOutlet private weak var hideConstraintCreateLessonView: NSLayoutConstraint!
    
    private let daysOfTheWeekDataSourse: [String] = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
    private var pressedAddButtonId: Int?
    
    private var currentSelectedDayIndex: Int?
    private var currentSelectedLessonIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsForDaysOfTheWeekCollectionView()
        daysView.delegate = self
        createLessonView.delegate = self
        selectedLessonView.delegate = self
        headerView.delegate = self
        settingView.delegate = self
    }
    
    private func settingsForDaysOfTheWeekCollectionView(){
        daysOfTheWeekCollectionView.delegate = self
        daysOfTheWeekCollectionView.dataSource = self
        daysOfTheWeekCollectionView.register(UINib(nibName: "DaysOfTheWeekCell", bundle: nil), forCellWithReuseIdentifier: DaysOfTheWeekCell.identifier)
    }
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysOfTheWeekDataSourse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = daysOfTheWeekCollectionView.dequeueReusableCell(withReuseIdentifier: DaysOfTheWeekCell.identifier, for: indexPath) as! DaysOfTheWeekCell
        cell.setupWith(day: daysOfTheWeekDataSourse[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(150), height: CGFloat(40))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? DaysOfTheWeekCell {
            cell.setMainColorForDayLabel()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DaysOfTheWeekCell {
            cell.setBlackColorForDayLabel()
        }
    }
}

//MARK: - DaysCellDelegate
extension ViewController: DaysCellDelegate{
    func moveLesson(moveRowAt: Int, destinationIndex: Int, dayIndex: Int) {
    }
    
    func showCreateLessonView(id: Int) {
        createLessonView.isHidden = false
        pressedAddButtonId = id
        createLessonView.changeCreateLessonViewType(createLessonViewType: .add)
    }
    
    func showSelectedLessonView(lessonIndex: Int, dayIndex: Int) {
        currentSelectedLessonIndex = lessonIndex
        currentSelectedDayIndex = dayIndex
        selectedLessonView.isHidden = false
    }
}

//MARK: - CreateLessonViewDelegate
extension ViewController: CreateLessonViewDelegate{
    func aditCurrentLesson(lesson: LessonModel) {
        guard let dayIndex = currentSelectedDayIndex, let lessonIndex = currentSelectedLessonIndex else { return }
        daysView.aditLessonToDataSource(lesson: lesson, dayIndex: dayIndex, lessonIndex: lessonIndex)
    }
    
    func addCurrentLesson(lesson: LessonModel) {
        guard let id = pressedAddButtonId else { return }
        daysView.addLessonToDataSource(lesson: lesson, dayIndex: id)
    }
    
    func changedDownHideConstraint() {
        hideConstraintCreateLessonView.constant = 60
    }
    
    func changedUpHideConstraint() {
        hideConstraintCreateLessonView.constant = -35
    }
    
    func hideCreateLessonView(){
        createLessonView.isHidden = true
    }
}


//MARK: - SelectedLessonViewDelegate
extension ViewController: SelectedLessonViewDelegate{
    func editSelectedLesson() {
        if let dayIndex = currentSelectedDayIndex, let lessonIndex = currentSelectedLessonIndex{
            let lessonModel = daysView.getLessonModelFromDataSource(dayIndex: dayIndex, lessonIndex: lessonIndex)
            createLessonView.setToTextFields(with: lessonModel)
        }
        createLessonView.isHidden = false
        createLessonView.changeCreateLessonViewType(createLessonViewType: .adit)
    }
    
    func deleteSelectedLesson() {
        if let dayIndex = currentSelectedDayIndex, let lessonIndex = currentSelectedLessonIndex{
            daysView.removeFromDataSource(dayIndex: dayIndex, lessonIndex: lessonIndex)
        }
        daysView.updateDaysCollectionView()
    }
    
    func hideSelectedLessonView() {
        selectedLessonView.isHidden = true
    }
}

//MARK: - HeaderViewDelegate
extension ViewController: HeaderViewDelegate{
    func pressedSettingButton(pressedFlag: Bool) {
        settingView.isHidden = pressedFlag ? false : true
    }
}

//MARK: - SettingViewDelegate
extension ViewController: SettingViewDelegate{
    func showDeleteAllAllert() {
        let allertController = UIAlertController()
    }
}
