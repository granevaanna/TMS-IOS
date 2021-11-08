//
//  CollectionViewCell.swift
//  galleryHM14
//
//  Created by Анна Гранёва on 5.11.21.
//

import UIKit

protocol PhotoCellDelegate: AnyObject{
    func likeOrDislike(photoName: String)
    func comment(photoName: String)
    func share()
}

final class CollectionCellModel{
    let photoImage: UIImage?
    let photoName: String
    var isLiked: Bool
    var commentString: String?
    
    init(imageString: String, commentString: String? = nil) {
        photoName = imageString
        photoImage = UIImage(named: imageString)
        isLiked = false
        self.commentString = commentString
    }
}

final class CollectionViewCell: UICollectionViewCell {
    static let identifier = "kCollectionViewCell"
    
    private var isLiked: Bool = false
    private var photoName = ""
    
    weak var delegate: PhotoCellDelegate?
    
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var buttonLiked: UIButton!
    @IBOutlet private weak var commentLabel: UILabel!
    
    func setupWith(model: CollectionCellModel){
        photoName = model.photoName
        photoImageView.image = model.photoImage
        isLiked = model.isLiked
        commentLabel.text = model.commentString
        
        let buttonLikeImage = UIImage(systemName: isLiked ? "heart.fill" : "heart")
        buttonLiked.setImage(buttonLikeImage, for: .normal)
    }
    func writeTextInCommentLabel(text: String){
        commentLabel.text = text
    }
}

//MARK: = Buttons Action
extension CollectionViewCell{
    @IBAction func buttonLikedAction(_ sender: Any) {
        delegate?.likeOrDislike(photoName: photoName)
    }
    
    @IBAction func buttonCommentAction(_ sender: Any) {
        delegate?.comment(photoName: photoName)
    }
    
    @IBAction func buttonShareAction(_ sender: Any) {
        delegate?.share()
    }
}
