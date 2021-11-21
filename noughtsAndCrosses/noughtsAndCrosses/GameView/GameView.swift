//
//  GameView.swift
//  noughtsAndCrosses
//
//  Created by Анна Гранёва on 21.11.21.
//

import UIKit

class GameView: UIView{
    @IBOutlet private var contentView: UIView!
    
    var dataSource: [String] = ["", "", "", "", "", "", "", "", ""]
    var flagToNoughtOrCross = false

    @IBOutlet weak var collectionView: UICollectionView!
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
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "GameCollectionCell", bundle: nil), forCellWithReuseIdentifier: GameCollectionCell.identifier)
        }
}


//MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension GameView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionCell.identifier, for: indexPath) as! GameCollectionCell
        cell.setupWith(pictureName: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGFloat(collectionView.frame.width / 3.2)
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if dataSource[indexPath.row].isEmpty{
            flagToNoughtOrCross.toggle()
            if flagToNoughtOrCross{
                dataSource[indexPath.row] = "cross"
            }else{
                dataSource[indexPath.row] = "nought"
            }
            collectionView.reloadData()
        }
    }
    
}
