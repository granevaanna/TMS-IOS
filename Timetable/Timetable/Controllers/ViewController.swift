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
    
    @IBOutlet private weak var hideConstraintCreateLessonView: NSLayoutConstraint!
    
    private let daysOfTheWeekDataSourse: [String] = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
//    var currentAddButtonTag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsForDaysOfTheWeekCollectionView()
        daysView.delegate = self
        createLessonView.delegate = self
//        daysView.daysViewDelegate = self
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
    func showCreateLessonView() {
        createLessonView.isHidden = false
    }
}

//MARK: - CreateLessonViewDelegate
extension ViewController: CreateLessonViewDelegate{
    func addCurrentLesson(lesson: LessonModel, index: Int) {
        daysView.addLessonToDataSource(lesson: lesson, dayIndex: index)
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

//MARK: - DaysViewDelegate
//extension ViewController: DaysViewDelegate{
//    func setButtonTag(tag: Int) {
//        currentAddButtonTag = tag
//    }
//}
