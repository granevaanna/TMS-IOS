//
//  HourlyViewCell.swift
//  TMS29
//
//  Created by lion on 15.01.22.
//

import UIKit

class HourlyViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
   
    static let identifier = "HourlyViewCell"
    private var dataSource:[WeatherModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: HourlyCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupWith(upcomingHoursWeatherModel: [WeatherModel]){
        self.dataSource = upcomingHoursWeatherModel
        collectionView.reloadData()
    }
    
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension HourlyViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as! HourlyCollectionViewCell
        cell.setupWith(upcomingHoursWeather: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80, height: collectionView.frame.height)
    }
    
    
    
    
    
    
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 2
//    }

    
    
    
}
    
   
    
    




//
//override func setSelected(_ selected: Bool, animated: Bool) {
//    super.setSelected(selected, animated: animated)
//
//    // Configure the view for the selected state
//}
