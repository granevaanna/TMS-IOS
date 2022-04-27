//
//  ActiveHomeWork.swift
//  Timetable
//
//  Created by Анна Гранёва on 11.04.22.
//

import UIKit

protocol ActiveHomeWorkDelegate: AnyObject{
    func enabledViews()
    func disableViews()
    func showDeleteHomeWorkAlert(at index: Int)
}

final class ActiveHomeWork: UIView{
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var createHomeWorkView: CreateHomeWorkView!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var hideConstraintCreateHomeWorkView: NSLayoutConstraint!
    @IBOutlet private(set) weak var selectedHomeWorkView: SelectedHomeWorkView!
    
    private var activeHomeWorks: [HomeWorkModel] {
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: "kToDoHomeWorkDataSource")
                UserDefaults.standard.synchronize()
            }
        }
        
        get {
            if let data = UserDefaults.standard.value(forKey: "kToDoHomeWorkDataSource") as? Data,
               let array = try? JSONDecoder().decode([HomeWorkModel].self, from: data) {
                return array
            } else {
                return []
            }
        }
    }
    
    weak var delegate: ActiveHomeWorkDelegate?
    private var selectedHomeWorkIndex: Int?

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
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "HomeWorkCell", bundle: nil), forCellReuseIdentifier: HomeWorkCell.identifier)
            createHomeWorkView.delegate = self
            selectedHomeWorkView.delegate = self
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
    
    func showCreateHomeWorkView(){
        createHomeWorkView.isHidden = false
    }
    
    func removeFromActiveHomeWorks(at index: Int){
        activeHomeWorks.remove(at: index)
    }
    
    func updateTableView(){
        tableView.reloadData()
    }
    
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//
//        if !selectedHomeWorkView.isHidden{
//            selectedHomeWorkView.isHidden = true
//            delegate?.enabledViews()
//        }
//    }
    
    @IBAction private func addButtonAction(_ sender: Any) {
        showCreateHomeWorkView()
        delegate?.disableViews()
        createHomeWorkView.changeCreateHomeWorkViewType(createHomeWorkViewType: .add)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedHomeWorkIndex = indexPath.row
        selectedHomeWorkView.isHidden = false
        delegate?.disableViews()
        createHomeWorkView.changeCreateHomeWorkViewType(createHomeWorkViewType: .adit)
    }
}

//MARK: - HomeWorkCellDelegate
extension ActiveHomeWork: HomeWorkCellDelegate{
    func changeIsDoneMeaning(id: Int) {
        activeHomeWorks[id].isDone.toggle()
        tableView.reloadData()
    }
}

//MARK: - CreateHomeWorkViewDelegate
extension ActiveHomeWork: CreateHomeWorkViewDelegate{
    func aditHomeWork(newHomeWork: HomeWorkModel) {
        guard let selectedIndex = selectedHomeWorkIndex else { return}
        activeHomeWorks[selectedIndex] = newHomeWork
        tableView.reloadData()
    }
    
    func changedUpHideConstraint() {
        hideConstraintCreateHomeWorkView.constant = -30
    }
    
    func changedDownHideConstraint() {
        hideConstraintCreateHomeWorkView.constant = 60
    }
    
    func addHomeWorkToActiveHomeworks(homeWork: HomeWorkModel) {
        activeHomeWorks.append(homeWork)
        tableView.reloadData()
    }
    
    func hideCreateHomeWorkView() {
        createHomeWorkView.isHidden = true
        delegate?.enabledViews()
    }
}

//MARK: - SelectedHomeWorkViewDelegate
extension ActiveHomeWork: SelectedHomeWorkViewDelegate{
    func deleteSelectedHomeWork() {
        guard let selectedIndex = selectedHomeWorkIndex else { return }
        delegate?.showDeleteHomeWorkAlert(at: selectedIndex)
    }
    
    func editSelectedHomeWork() {
        guard let selectedIndex = selectedHomeWorkIndex else { return }
        hideSelectedHomeWorkView()
        createHomeWorkView.setToTextFields(homeWork: activeHomeWorks[selectedIndex])
        showCreateHomeWorkView()
    }
    
    func hideSelectedHomeWorkView(){
        selectedHomeWorkView.isHidden = true
    }
    
}

