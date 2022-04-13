//
//  ActiveHomeWork.swift
//  Timetable
//
//  Created by Анна Гранёва on 11.04.22.
//

import UIKit

final class ActiveHomeWork: UIView{
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addButton: UIButton!
    
    private var activeHomeWorks: [HomeWorkModel] = []
    
    weak var delegate: HeaderViewDelegate?

    override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        
        private func commonInit() {
            Bundle.main.loadNibNamed("\(type(of: self))", owner: self, options: nil)
            addSubview(contentView)
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//            tableView.backgroundColor = UIColor(named: "backgroundColor")
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "HomeWorkCell", bundle: nil), forCellReuseIdentifier: HomeWorkCell.identifier)
            print(activeHomeWorks)
        }
    
    func setActiveHomeWork(activeHomeWorks: [HomeWorkModel]){
        self.activeHomeWorks = activeHomeWorks
    }
    
    func disableTableView(){
        tableView.isUserInteractionEnabled = false
        addButton.isEnabled = false
    }
    
    func enabledTableView(){
        tableView.isUserInteractionEnabled = true
        addButton.isEnabled = true
    }
    
    
    @IBAction private func addButtonAction(_ sender: Any) {
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource
extension ActiveHomeWork: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeHomeWorks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeWorkCell.identifier, for: indexPath) as! HomeWorkCell
        cell.setup(with: activeHomeWorks[indexPath.row], addButtonId: indexPath.row)
        cell.delegate = self
        return cell
    }
}

//MARK: - HomeWorkCellDelegate
extension ActiveHomeWork: HomeWorkCellDelegate{
    func changeIsDoneMeaning(id: Int) {
        activeHomeWorks[id].isDone.toggle()
        tableView.reloadData()
    }
}
