//
//  PhotoTableCell.swift
//  priofileApplicationHW22
//
//  Created by Анна Гранёва on 5.12.21.
//

import UIKit

final class PhotoTableCell: UITableViewCell {
    static let identifier = "kDataTableCell"
    @IBOutlet private weak var photoImageView: UIImageView!

    func setupWith(){
        if let photoNameString = defaults.string(forKey: PhotoTableCell.identifier){
        photoImageView.image = UIImage(named: photoNameString)
        } else{
            photoImageView.image = UIImage(systemName: "photo")
        }
    }
    
    @IBAction func editAction(_ sender: Any) {
        EditViewController.controllerType = .photo
        NotificationCenter.default.post(name: .openEditViewController, object: nil)
    }
}
