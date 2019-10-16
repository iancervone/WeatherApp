//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Ian Cervone on 10/14/19.
//  Copyright © 2019 Ian Cervone. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var zipcodeTextField: UITextField!
  @IBOutlet weak var weatherCollectionView: UICollectionView!
  
  
  var forecast = Forecast(latitude: Double, longitude: Double, daily: String) {
    didSet {
      weatherCollectionView.reloadData()
      
    }
  }
  
  var zipcodeEntered: String? = nil {
    didSet {
      weatherCollectionView.reloadData()
    }
  }
    
  var latLong: String? {
    didSet {
      weatherCollectionView.reloadData()
     // getLatLong()
    }
  }
  
  var cityName: String? {
    didSet {
      weatherCollectionView.reloadData()
     // getLatLong()
    }
  }
  
  
  override func viewDidLoad() {
      super.viewDidLoad()
      weatherCollectionView.dataSource = self
      weatherCollectionView.delegate = self
      zipcodeTextField.delegate = self
    }
  
  
  private func getLatLong() {
  ZipCodeHelper.getLatLong(fromZipCode: zipcodeEntered ?? "10128"){ (result) in
      switch result {
      case let .success((lat, long, name)):
        self.latLong = "\(lat),\(long)"
        self.cityName = name
        DispatchQueue.global().async {
          DarkSkyAPIClient.manager.getForecast(from: self.latLong ?? "37.8267,-122.4233") { (result) in
            DispatchQueue.main.async { [weak self] in
              switch result {
              case let .success(forecast):
                self?.forecast = forecast
              case let .failure(error):
                self?.displayErrorAlert(with: error)
              }
            }
          }
        }
      case let .failure(error):
          print(error)
      }
    }
   // loadData()
  }
  
  
  private func loadData() {
    DarkSkyAPIClient.manager.getForecast(from: latLong ?? "37.8267,-122.4233") { (result) in
      DispatchQueue.main.async { [weak self] in
        switch result {
        case let .success(forecast):
          self?.forecast = forecast
        case let .failure(error):
          self?.displayErrorAlert(with: error)
        }
      }
    }
  }
  
  func displayErrorAlert(with error: AppError) {
    let alertVC = UIAlertController(title: "Error Fetching Data", message: "\(error)", preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
    present(alertVC, animated: true, completion: nil)
  }
  

}


extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return forecast.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell else {
      fatalError("expectd WeatherCollectionViewCEll but got something else")
    }
    let weather = forecast[indexPath.row]
    cell.cellHighLabel.text = "\(weather.daily.temperatureHigh) degrees F"
    cell.cellLowLabel.text = "\(weather.daily.temperatureLow) degrees F"
    return cell
  }
}


extension WeatherViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        zipcodeEntered = textField.text
getLatLong()
    //loadData()
    zipcodeTextField.resignFirstResponder()

    return true
  }
  
  
//  func textFieldDidEndEditing(_ textField: UITextField) {
//    zipcodeEntered = textField.text
//
//    loadData()
//  }
//  func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
//    zipcodeTextField.resignFirstResponder()
//  }
}
