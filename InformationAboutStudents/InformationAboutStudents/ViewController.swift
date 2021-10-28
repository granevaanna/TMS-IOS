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
        StudentModel(nameString: "Petya", markString: 50, groupString: 5),
        StudentModel(nameString: "Vanya", markString: 40, groupString: 4),
        StudentModel(nameString: "Vasya", markString: 70, groupString: 9),
        StudentModel(nameString: "Petya", markString: 50, groupString: 9),
        StudentModel(nameString: "Vanya", markString: 40, groupString: 4),
        StudentModel(nameString: "Vasya", markString: 70, groupString: 4),
        StudentModel(nameString: "Petya", markString: 50, groupString: 5),
        StudentModel(nameString: "Vanya", markString: 40, groupString: 5),
        StudentModel(nameString: "Vasya", markString: 70, groupString: 5)]
    
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "StudentCell", bundle: nil), forCellReuseIdentifier: StudentCell.identifier)
        tableView.register(UINib(nibName: "FooterCells", bundle: nil), forCellReuseIdentifier: FooterCells.identifier)
    }
}



//MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        var numberOfSection: Int = 0
//        for i in 0...sortStudentArray.count - 2 {
//            if sortStudentArray[i].groupString != sortStudentArray[i+1].groupString{
//                numberOfSection += 1
//            }
//        }
//        return numberOfSection + 1 + 1
        
        return setGroupArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let numberOfcellsInSection: [Int] = numberOfcellsInAllSection(studentArray: studentArray)
//        if section == 0{
//            return numberOfcellsInSection[0]
//        } else if section == 1{
//            return numberOfcellsInSection[1]
//        }else if section == 2{
//            return numberOfcellsInSection[2]
//        }else {
//            return 1
//        }
        let group = setGroupArray[section]
        let students = sortStudentArray.filter({$0.groupString == group})
        return students.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let numberOfcellsInSection: [Int] = numberOfcellsInAllSection(studentArray: studentArray)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentCell.identifier, for: indexPath) as! StudentCell
        
        let group = setGroupArray[indexPath.section]
        let students = studentArray.filter({$0.groupString == group})
        cell.setupCellWith(model: students[indexPath.row])
        return cell
        
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: StudentCell.identifier, for: indexPath) as! StudentCell
//            cell.setupCellWith(model: sortStudentArray[indexPath.row])
//            return cell
//        }else if indexPath.section == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: StudentCell.identifier, for: indexPath) as! StudentCell
//            cell.setupCellWith(model: sortStudentArray[numberOfcellsInSection[0] + indexPath.row])
//            return cell
//        } else if indexPath.section == 2 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: StudentCell.identifier, for: indexPath) as! StudentCell
//            cell.setupCellWith(model: sortStudentArray[numberOfcellsInSection[0] + numberOfcellsInSection[1] + indexPath.row])
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: FooterCells.identifier, for: indexPath) as! FooterCells
//            cell.setupCellWith(model: sortStudentArray)
//            return cell
//        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        return "Group: \(setGroupArray[section])"
    }
    
    
//    
//    func numberOfcellsInAllSection(studentArray: [StudentModel]) -> [Int]{
//        var numberOfSection: Int = 0
//        var numberOfcellsInSection: [Int] = [1]
//        for i in 0...sortStudentArray.count - 2 {
//            if sortStudentArray[i].groupString != sortStudentArray[i+1].groupString{
//                numberOfSection += 1
//                numberOfcellsInSection.append(1)
//            }else{
//                numberOfcellsInSection[numberOfSection] = numberOfcellsInSection[numberOfSection] + 1
//            }
//        }
//        return numberOfcellsInSection
//    }
}

