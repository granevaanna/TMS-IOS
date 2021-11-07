//
//  CollectionViewCell.swift
//  galleryHM14
//
//  Created by Анна Гранёва on 5.11.21.
//

import UIKit

protocol PhotoCellDelegate: AnyObject{
    func likeOrDislike(photoName: String)
    func comment()
    func share()
}

final class CollectionCellModel{
    let photoImage: UIImage?
    let photoName: String
    var isLiked: Bool
    
    init(imageString: String) {
        photoName = imageString
        photoImage = UIImage(named: imageString)
        isLiked = false
    }
}

final class CollectionViewCell: UICollectionViewCell {
    static let identifier = "kCollectionViewCell"
    
    private var isLiked: Bool = false
    private var photoName = ""
    
    weak var delegate: PhotoCellDelegate?
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var buttonLiked: UIButton!
    
    func setupWith(model: CollectionCellModel){
        photoName = model.photoName
        photoImageView.image = model.photoImage
        isLiked = model.isLiked
        
        let buttonLikeImage = UIImage(systemName: isLiked ? "heart.fill" : "heart")
        buttonLiked.setImage(buttonLikeImage, for: .normal)
    }
}

//MARK: = Buttons Action
extension CollectionViewCell{
    @IBAction func buttonLikedAction(_ sender: Any) {
        delegate?.likeOrDislike(photoName: photoName)
    }
    
    @IBAction func buttonCommentAction(_ sender: Any) {
        delegate?.comment()
    }
    
    @IBAction func buttonShareAction(_ sender: Any) {
        delegate?.share()
    }
}
