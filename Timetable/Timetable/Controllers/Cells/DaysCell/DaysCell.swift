//
//  DaysCell.swift
//  Timetable
//
//  Created by Анна Гранёва on 16.02.22.
//

import UIKit

protocol DaysCellDelegate: AnyObject{
    func showCreateLessonView()
}

final class DaysCell: UICollectionViewCell {
    static let identifier = "kDaysCell"
    @IBOutlet weak var tableView: UITableView!
    var lessons: [LessonModel] = []
    weak var delegate: DaysCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LessonCell", bundle: nil), forCellReuseIdentifier: LessonCell.identifier)
    }
    
    func setup(with lessons: [LessonModel]) {
        self.lessons = lessons
        tableView.reloadData()
    }
    
    @IBAction private func addLessonButtonAction(_ sender: Any) {
        delegate?.showCreateLessonView()
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
    
}
