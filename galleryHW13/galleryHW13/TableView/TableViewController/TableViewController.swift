//
//  TableViewController.swift
//  galleryHW13
//
//  Created by Анна Гранёва on 3.11.21.
//

import UIKit

final class TableViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    var dataSource: [String] = ["photo1", "photo2", "photo3", "photo4", "photo5", "photo6", "photo7", "photo8", "photo9", "photo1", "photo2", "photo3", "photo4", "photo5", "photo6", "photo7", "photo8", "photo9", "photo1", "photo2", "photo3", "photo4", "photo5", "photo6", "photo7", "photo8", "photo9", "photo1", "photo2", "photo3", "photo4", "photo5", "photo6", "photo7", "photo8", "photo9", "photo1", "photo2", "photo3", "photo4", "photo5", "photo6", "photo7", "photo8", "photo9"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PhotoCellTable", bundle: nil), forCellReuseIdentifier: PhotoCellTable.identifier)
    }
    
    @IBAction func moveToCollection(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
            let collectionView = storyboard.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
            self.present(collectionView, animated:true, completion:nil)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension TableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCellTable.identifier, for: indexPath) as! PhotoCellTable
        cell.setupWithPhoto(photoName: dataSource[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = PhotoViewController(nibName: "PhotoViewController", bundle: nil)
        PhotoViewController.index = indexPath.row
        present(controller, animated: true, completion: nil)
    }
}
