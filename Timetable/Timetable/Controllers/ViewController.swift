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
    private let daysOfTheWeekDataSourse: [String] = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsForDaysCollectionView()
    }
    
    private func settingsForDaysCollectionView(){
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
//        collectionView.cellForItem(at: indexPath)?.backgroundColor = .mainColor
    }
    
}

