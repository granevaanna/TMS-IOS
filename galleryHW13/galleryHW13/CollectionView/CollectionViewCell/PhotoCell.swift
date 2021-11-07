//
//  PhotoCell.swift
//  galleryHW13
//
//  Created by Анна Гранёва on 2.11.21.
//

import UIKit

final class PhotoCell: UICollectionViewCell {

    @IBOutlet private weak var photoImageView: UIImageView!
    
    static let identifier = "kPhotoCell"
    
    func setupWithPhoto(photoName: String){
        photoImageView.image = UIImage(named: photoName)
    }
}
