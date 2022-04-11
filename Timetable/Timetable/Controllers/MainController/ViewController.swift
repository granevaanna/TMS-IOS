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
    private var daysOfTheWeekDataSourse: [DayOfTheWeekModel] = [DayOfTheWeekModel(dayName: "Пн"), DayOfTheWeekModel(dayName: "Вт"), DayOfTheWeekModel(dayName: "Ср"), DayOfTheWeekModel(dayName: "Чт"), DayOfTheWeekModel(dayName: "Пт"), DayOfTheWeekModel(dayName: "Сб"), DayOfTheWeekModel(dayName: "Вс")]
    
    private var pressedAddButtonId: Int?
    
    private var currentSelectedDayIndex: Int?
    private var currentSelectedLessonIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionSettings()
        daysView.delegate = self
        createLessonView.delegate = self
        selectedLessonView.delegate = self
        headerView.delegate = self
        settingView.delegate = self
        daysOfTheWeekDataSourse[getCurrentDayIndex()].isSelect = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        daysView.scrollTo(day: getCurrentDayIndex())
    }
    
    private func setupCollectionSettings(){
        daysOfTheWeekCollectionView.delegate = self
        daysOfTheWeekCollectionView.dataSource = self
        daysOfTheWeekCollectionView.register(UINib(nibName: "DaysOfTheWeekCell", bundle: nil), forCellWithReuseIdentifier: DaysOfTheWeekCell.identifier)
    }
    
    func getCurrentDayIndex() -> Int{
        let date = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        if weekday == 1{
            return 6
        } else{
            return weekday - 2
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        if !selectedLessonView.isHidden{
            selectedLessonView.isHidden = true
            enabledViews()
        }
        
        if !settingView.isHidden{
            settingView.isHidden = true
            enabledViews()
        }
    }
    
    private func enabledViews(){
        headerView.enabledSettingButton()
        daysOfTheWeekCollectionView.isUserInteractionEnabled = true
        daysView.enabledDaysCollectionView()
    }
    
    private func disableViews(){
        headerView.disableSettingButton()
        daysOfTheWeekCollectionView.isUserInteractionEnabled = false
        daysView.disableDaysCollectionView()
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
        return CGSize(width: CGFloat(view.frame.width / 8.2), height: CGFloat(40))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        for i in 0...daysOfTheWeekDataSourse.count - 1{
            daysOfTheWeekDataSourse[i].isSelect = false
        }
        daysOfTheWeekDataSourse[indexPath.row].isSelect = true
        daysOfTheWeekCollectionView.reloadData()
        
        daysView.scrollTo(day: indexPath.row)
    }
}

//MARK: - DaysViewScrollDelegate
extension ViewController: DaysViewScrollDelegate {
    func didScrollto(indexPath: IndexPath) {
        
        for i in 0...daysOfTheWeekDataSourse.count - 1{
            daysOfTheWeekDataSourse[i].isSelect = false
        }
        daysOfTheWeekDataSourse[indexPath.row].isSelect = true
        daysOfTheWeekCollectionView.reloadData()
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
        
        disableViews()
    }
    
    func showSelectedLessonView(lessonIndex: Int, dayIndex: Int) {
        currentSelectedLessonIndex = lessonIndex
        currentSelectedDayIndex = dayIndex
        selectedLessonView.isHidden = false
        
        disableViews()
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
        hideConstraintCreateLessonView.constant = -5
    }
    
    func hideCreateLessonView(){
        createLessonView.isHidden = true
        enabledViews()
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
        showDeleteLessonAlert()
    }
    
    func hideSelectedLessonView() {
        selectedLessonView.isHidden = true
    }
    
    private func showDeleteLessonAlert(){
        let alertController = UIAlertController(title: "", message: "Вы точно хотите удалить занятие?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Да", style: .default, handler: { [weak self] ok in
            if let dayIndex = self?.currentSelectedDayIndex, let lessonIndex = self?.currentSelectedLessonIndex{
                self?.daysView.removeFromDataSource(dayIndex: dayIndex, lessonIndex: lessonIndex)
            }
            self?.daysView.updateDaysCollectionView()
            self?.enabledViews()
        }))
        alertController.addAction(UIAlertAction(title: "Нет", style: .default, handler: { [weak self] cancel in
            self?.enabledViews()
        }))
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: - HeaderViewDelegate
extension ViewController: HeaderViewDelegate{
    func showSettingView() {
        settingView.isHidden = false
        disableViews()
    }
}

//MARK: - SettingViewDelegate
extension ViewController: SettingViewDelegate{
    func editTableView() {
        settingView.isHidden = true
        daysView.updateDaysCollectionView()
        enabledViews()
    }
    
    func showDeleteAllAlert() {
        settingView.isHidden = true
        let alertController = UIAlertController(title: "", message: "Вы точно хотите очистить расписание?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Да", style: .default, handler: { [weak self] ok in
            self?.daysView.removeAllFromDataSource()
            self?.enabledViews()
        }))
        alertController.addAction(UIAlertAction(title: "Нет", style: .default, handler: { [weak self] cancel in
                self?.enabledViews()
        }))
        present(alertController, animated: true, completion: nil)
    }
}
