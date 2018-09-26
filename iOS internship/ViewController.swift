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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityText.delegate = self
        
        //        model.loadNewData(dismiss(animated: <#T##Bool#>, completion: {
        //            DispatchAsync {
        //
        //                cityTableView.reloadData()
        //            }
        //        }))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cityModel.cityArray.count>0{
            return cityModel.cityArray.count
        } else {
            return 0
        }
    }
    
    //    loadedData(compelte: () -> () ) {
    //
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        
        let cellText = "\(cityModel.cityArray[indexPath.row].cityName) \(cityModel.cityArray[indexPath.row].countryName) \(cityModel.cityArray[indexPath.row].administrativeAriaID)"
        
        cell.textLabel?.text = cellText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    
    
}

