//
//  DaysView.swift
//  Timetable
//
//  Created by Анна Гранёва on 16.02.22.
//

import UIKit

//protocol DaysViewDelegate: AnyObject{
//    func setButtonTag(tag: Int)
//}

final class DaysView: UIView{
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var daysCollectionView: UICollectionView!
    var dataSource:[[LessonModel]] = [[LessonModel(lessonName: "Математика", teacher: "Препод", audience: "409", startTime: "10:00", endTime: "11:20"), LessonModel(lessonName: "Математика", teacher: "Препод", audience: "409", startTime: "10:00", endTime: "11:20")], [], [], [], [], [], []]
    weak var delegate: DaysCellDelegate?
//    weak var daysViewDelegate: DaysViewDelegate?
    
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
            daysCollectionView.delegate = self
            daysCollectionView.dataSource = self
            daysCollectionView.register(UINib(nibName: "DaysCell", bundle: nil), forCellWithReuseIdentifier: DaysCell.identifier)
        }
    func addLessonToDataSource(lesson: LessonModel, dayIndex: Int){
        dataSource[dayIndex].append(lesson)
        daysCollectionView.reloadData()
    }
    
//    @objc func setNumberFromArray( _ button: UIButton) {
//        let buttonTag = button.tag
//
//        print(buttonTag)
//
//
//        daysViewDelegate?.setButtonTag(tag: buttonTag)
//    }
    
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension DaysView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = daysCollectionView.dequeueReusableCell(withReuseIdentifier: DaysCell.identifier, for: indexPath) as! DaysCell
        cell.setup(with: dataSource[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(contentView.frame.width), height: CGFloat(contentView.frame.height))
    }
}

//MARK: - DaysCellDelegate
extension DaysView: DaysCellDelegate{
    func showCreateLessonView() {
        delegate?.showCreateLessonView()
    }
}
