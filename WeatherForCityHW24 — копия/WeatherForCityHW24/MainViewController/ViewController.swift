//
//  ViewController.swift
//  WeatherForCityHW24
//
//  Created by Анна Гранёва on 10.12.21.
//

import UIKit

enum ForecastType{
    case currentForecast
    case dailyForecast
}

class ViewController: UIViewController {
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var forecastTypeButton: UIButton!
    
    private let cityDataSource: [String] = ["minsk",
                                            "brest",
                                            "gomel",
                                            "mogilev",
                                            "grodno",
                                            "vitebsk"]
    private var cityTempString: String?
    private var cityPicker: UIPickerView?
    private var forecastType: ForecastType = .currentForecast

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCityPicker()
        textField.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionCustomViewCell", bundle: nil), forCellWithReuseIdentifier: CollectionCustomViewCell.identifier)
    }
    
    @IBAction func currentForecastAction(_ sender: Any) {
        
        if let cityString = textField.text, !cityString.isEmpty{
            textField.layer.borderWidth = 0
            if forecastType == .currentForecast{
                forecastType = .dailyForecast
                forecastTypeButton.setTitle("Увидеть текущую погоду", for: .normal)
                collectionView.reloadData()
            } else {
                forecastType = .currentForecast
                forecastTypeButton.setTitle("Увидеть прогноз по часам", for: .normal)
                collectionView.reloadData()
            }
        } else {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = .init(red: 1, green: 0, blue: 0, alpha: 1)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

//MARK: - cityPickerFunctions
extension ViewController{
    private func setupCityPicker() {
        cityPicker = UIPickerView()
        cityPicker?.dataSource = self
        cityPicker?.delegate = self
        
        textField.inputAccessoryView = createdToolbar()
        textField.inputView = cityPicker
    }
    
    func createdToolbar() -> UIToolbar{
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePickerAction))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        return toolbar
    }
    
    @objc func donePickerAction() {
        textField.text = cityTempString
        view.endEditing(true)
        collectionView.reloadData()
        
        if let city = textField.text, !city.isEmpty{
            textField.layer.borderWidth = 0
            //getWeatherFor(city: city)
        } else {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = .init(red: 1, green: 0, blue: 0, alpha: 1)
        }
    }
    
    @objc func cancelDatePicker(){
        view.endEditing(true)
    }
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSourc
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityDataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityTempString = cityDataSource[row]
    }
}


//MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if forecastType == .currentForecast{
            return 1
        } else {
            return 40
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCustomViewCell.identifier, for: indexPath) as! CollectionCustomViewCell
        if let city = textField.text{
            if forecastType == .currentForecast{
                cell.getWeatherFor(city: city)
            } else {
                cell.getDailyWeatherFor(city: city, index: indexPath.row)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if forecastType == .currentForecast{
            let size = CGFloat(collectionView.frame.width)
            return CGSize(width: size, height: size/2.6)
        } else {
            let size = CGFloat(collectionView.frame.width / 2.06)
            return CGSize(width: size, height: size/1.5)
        }
    }
}
