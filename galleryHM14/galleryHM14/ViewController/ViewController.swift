//
//  ViewController.swift
//  galleryHM14
//
//  Created by Анна Гранёва on 5.11.21.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    let dataSource: [CollectionCellModel] = [
        CollectionCellModel(imageString: "photo1"),
        CollectionCellModel(imageString: "photo2"),
        CollectionCellModel(imageString: "photo3"),
        CollectionCellModel(imageString: "photo4"),
        CollectionCellModel(imageString: "photo5"),
        CollectionCellModel(imageString: "photo6"),
        CollectionCellModel(imageString: "photo7"),
        CollectionCellModel(imageString: "photo8"),
        CollectionCellModel(imageString: "photo9")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        navigationItem.title = "My Instagram"
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.setupWith(model: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemPerRow: CGFloat = 3
        let paddingWidth = 20 * (itemPerRow + 1)
        let widthForItem = (collectionView.frame.width - paddingWidth) / itemPerRow
        return CGSize(width: widthForItem, height: widthForItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SecondViewController(nibName: "SecondViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
