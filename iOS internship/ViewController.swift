//
//  ViewController.swift
//  iOS internship
//
//  Created by pavels.vetlugins on 25/09/2018.
//  Copyright © 2018 pavels.vetlugins. All rights reserved.
//

import UIKit
import Freddy


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var cityText: UITextField!
    
    @IBOutlet weak var cityTableView: UITableView!
    
    var cityName = ""
    
    let cityModel: CityModel = CityModel()
    
    var location = ""
    var city = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityText.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cityModel.cityArray.count>0{
            return cityModel.cityArray.count
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cityNameCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        
        let cellText = "\(cityModel.cityArray[indexPath.row].cityName) \(cityModel.cityArray[indexPath.row].countryName) \(cityModel.cityArray[indexPath.row].administrativeAriaID)"
        
        cityNameCell.textLabel?.text = cellText
        
        return cityNameCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        location = cityModel.cityArray[indexPath.row].locationKey
        city = cityModel.cityArray[indexPath.row].cityName
        
        print(location)
        performSegue(withIdentifier: "forecastSegue", sender: cell)
    }
    
    func textFieldShouldReturn(_ textField: UITextField)->Bool{
        if let tempCityName = cityText.text{
            cityModel.fetchCity(city: tempCityName){ (result) -> () in
                print(result)
                
                DispatchQueue.main.async(execute:{() -> Void in
                    self.cityTableView.reloadData()
                })
            }
        }
        textField.resignFirstResponder()
        return true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparingSeg")
        if segue.identifier == "forecastSegue", let destinationVC = segue.destination as? ForecastViewController {
                destinationVC.location = location
                destinationVC.city = city
        }
        
    }
    
}

