//
//  DaysCell.swift
//  Timetable
//
//  Created by Анна Гранёва on 16.02.22.
//

import UIKit

protocol DaysCellDelegate: AnyObject{
    func showCreateLessonView(id: Int)
    func showSelectedLessonView(lessonIndex: Int, dayIndex: Int)
    func moveLesson(moveRowAt: Int, destinationIndex: Int, dayIndex: Int)
}

final class DaysCell: UICollectionViewCell {
    static let identifier = "kDaysCell"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var emptyLessonsView: EmptyLessonsView!
    
    private var lessons: [LessonModel] = []
    weak var delegate: DaysCellDelegate?
    
    private var addButtonId: Int?
    private var dayIdForSelectedLesson: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LessonCell", bundle: nil), forCellReuseIdentifier: LessonCell.identifier)
//        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
//        tableView.addGestureRecognizer(longPressGesture)
        
//        tableView.isEditing = true
    }
    
//    @objc private func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer){
//        switch gesture.state{
//        case .began:
//            tableView.isEditing = true
//        case .ended:
//            tableView.isEditing = false
//        @unknown default:
//            tableView.isEditing = false
//        }
//    }
    
    func setup(with lessons: [LessonModel], addButtonId: Int, dayIndex: Int) {
        self.lessons = lessons
        self.addButtonId = addButtonId
        dayIdForSelectedLesson = dayIndex
        if lessons.isEmpty {
            showEmptyLessonsView()
        } else {
            showTableWithLessons()
        }
        tableView.reloadData()
    }
    
    func showEmptyLessonsView(){
        emptyLessonsView.isHidden = false
        tableView.isHidden = true
    }
    
    func showTableWithLessons(){
        emptyLessonsView.isHidden = true
        tableView.isHidden = false
    }
    
    @IBAction private func addLessonButtonAction(_ sender: Any) {
        if let id = addButtonId {
            delegate?.showCreateLessonView(id: id)
        }
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource
extension DaysCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LessonCell.identifier, for: indexPath) as! LessonCell
        cell.setupWith(lesson: lessons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(20)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dayId = dayIdForSelectedLesson{
            delegate?.showSelectedLessonView(lessonIndex: indexPath.row, dayIndex: dayId)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if let dayId = dayIdForSelectedLesson{
            delegate?.moveLesson(moveRowAt: sourceIndexPath.row, destinationIndex: destinationIndexPath.row, dayIndex: dayId)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
