//
//  SecondViewController.swift
//  galleryHM14
//
//  Created by Анна Гранёва on 8.11.21.
//

import UIKit

 final class SecondViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    let dataSource: [CollectionCellModel] = [
        CollectionCellModel(imageString: "photo7"),
        CollectionCellModel(imageString: "photo2"),
        CollectionCellModel(imageString: "photo3"),
        CollectionCellModel(imageString: "photo4"),
        CollectionCellModel(imageString: "photo5"),
        CollectionCellModel(imageString: "photo6"),
        CollectionCellModel(imageString: "photo1"),
        CollectionCellModel(imageString: "photo8"),
        CollectionCellModel(imageString: "photo9")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        navigationItem.title = "Публикации"
        
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.setupWith(model: dataSource[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemPerRow: CGFloat = 1
        let paddingWidth = 20 * (itemPerRow + 1)
        let widthForItem = (collectionView.frame.width - paddingWidth) / itemPerRow
        return CGSize(width: widthForItem, height: widthForItem + 70)
    }
}

//MARK: - PhotoCellDelegate
extension SecondViewController: PhotoCellDelegate{
    func likeOrDislike(photoName: String) {
        dataSource.first(where: { $0.photoName == photoName })?.isLiked.toggle()
        collectionView.reloadData()
    }
    
    func comment(photoName: String) {
        let alert = UIAlertController(title: "Комментарий", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Введите ваш комментарий"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        })
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            guard let comment = alert.textFields?.first?.text else {return}
            
            self.dataSource.first(where: {$0.photoName == photoName})?.commentString = comment
            self.collectionView.reloadData()
            
//            NSLog("The \"OK\" alert occured.")
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func share() {
        
    }
}
