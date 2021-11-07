//
//  PhotoViewController.swift
//  galleryHW13
//
//  Created by Анна Гранёва on 4.11.21.
//

import UIKit

final class PhotoViewController: UIViewController {
    @IBOutlet weak var photoImageViewController: UIImageView!
    static var index: Int = 0
    
    var dataSource: [String] = ["photo1", "photo2", "photo3", "photo4", "photo5", "photo6", "photo7", "photo8", "photo9", "photo1", "photo2", "photo3", "photo4", "photo5", "photo6", "photo7", "photo8", "photo9", "photo1", "photo2", "photo3", "photo4", "photo5", "photo6", "photo7", "photo8", "photo9", "photo1", "photo2", "photo3", "photo4", "photo5", "photo6", "photo7", "photo8", "photo9", "photo1", "photo2", "photo3", "photo4", "photo5", "photo6", "photo7", "photo8", "photo9"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageViewController.image = UIImage(named: dataSource[PhotoViewController.index])
    }
}
