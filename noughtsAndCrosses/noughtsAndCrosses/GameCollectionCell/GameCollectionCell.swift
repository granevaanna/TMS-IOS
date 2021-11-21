//
//  GameCollectionCell.swift
//  noughtsAndCrosses
//
//  Created by Анна Гранёва on 21.11.21.
//

import UIKit

class GameCollectionCell: UICollectionViewCell {
    static let identifier = "kGameCollectionCell"
    
    @IBOutlet private weak var photoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupWith(pictureName: String){
        photoImage.image = UIImage(named: pictureName)
    }
}
