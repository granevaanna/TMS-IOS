//
//  PhotoCellTable.swift
//  galleryHW13
//
//  Created by Анна Гранёва on 3.11.21.
//

import UIKit

final class PhotoCellTable: UITableViewCell {
    @IBOutlet private weak var photoImageViewTable: UIImageView!
    
    static let identifier = "kPhotoCellTable"
    
    func setupWithPhoto(photoName: String){
        photoImageViewTable.image = UIImage(named: photoName)
    }
}
