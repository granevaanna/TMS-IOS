//
//  ViewController.swift
//  InformationAboutStudents
//
//  Created by Анна Гранёва on 26.10.21.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private var studentArray:[StudentModel] = [
        StudentModel(nameString: "Акулич Артур", markString: 7, groupString: 9),
        StudentModel(nameString: "Барановская Виктория", markString: 5, groupString: 10),
        StudentModel(nameString: "Галынин Владислав", markString: 7, groupString: 10),
        StudentModel(nameString: "Гранёва Анна", markString: 8, groupString: 9),
        StudentModel(nameString: "Кирий Светлана", markString: 4, groupString: 2),
        StudentModel(nameString: "Кохнович Роман", markString: 5, groupString: 2),
        StudentModel(nameString: "Евтеев Вадим", markString: 7, groupString: 2),
        StudentModel(nameString: "Пожога Кристина", markString: 8, groupString: 10),
        StudentModel(nameString: "Протосовицкий Вячеслав", markString: 4, groupString: 9),
        StudentModel(nameString: "Рабец Владислав", markString: 9, groupString: 2),
        StudentModel(nameString: "Пахомович Ксения", markString: 8, groupString: 9),
        StudentModel(nameString: "Красин Федор", markString: 7, groupString: 2),
        StudentModel(nameString: "Стасенко Татьяна", markString: 10, groupString: 9),
        StudentModel(nameString: "Сарнацкая Дарья", markString: 8, groupString: 9),
        StudentModel(nameString: "Тимофей Жук", markString: 5, groupString: 10),
        StudentModel(nameString: "Градович Елизавета", markString: 9, groupString: 9),
        StudentModel(nameString: "Вербицкий Максим", markString: 6, groupString: 10),
        StudentModel(nameString: "Корчинский Илья", markString: 7, groupString: 2),
        StudentModel(nameString: "Левкович Елизавета", markString: 5, groupString: 10),
        StudentModel(nameString: "Ефремов Роман", markString: 7, groupString: 9),
        StudentModel(nameString: "Владыковский Дмитрий", markString: 7, groupString: 10 ),
        StudentModel(nameString: "Филинкова Дарья", markString: 8, groupString: 9)]
    
    private var sortStudentArray: [StudentModel] {
        studentArray.sorted(by: {$0.groupString <= $1.groupString})
    }
    
    private var setGroupArray: [Int] {
        let groupArray = sortStudentArray.compactMap({ $0.groupString })
        let set = Set(groupArray)
        return set.sorted()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "3 курс"
        //self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "StudentCell", bundle: nil), forCellReuseIdentifier: StudentCell.identifier)
        tableView.register(UINib(nibName: "FooterCells", bundle: nil), forCellReuseIdentifier: FooterCells.identifier)
        tableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: HeaderCell.identifier)
    }
}



//MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return setGroupArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = setGroupArray[section]
        let students = sortStudentArray.filter({$0.groupString == group})
        return students.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentCell.identifier, for: indexPath) as! StudentCell
        
        let group = setGroupArray[indexPath.section]
        let students = studentArray.filter({$0.groupString == group})
        let sortStudent = students.sorted(by: {$0.nameString <= $1.nameString})
        cell.setupCellWith(model: sortStudent[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier) as! HeaderCell
        cell.headerLabel.text = "Группа: \(setGroupArray[section])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FooterCells.identifier) as! FooterCells
        let group = setGroupArray[section]
        let students = studentArray.filter({$0.groupString == group})
        cell.setupCellWith(model: students)
        return cell
    }
}

