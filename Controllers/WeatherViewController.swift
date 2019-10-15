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
  
  
  var forecast = [Forecast]() {
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

    }
  }
  
//  var getLatLong() {
//  ZipCodeHelper.get
//  }
  
  override func viewDidLoad() {
      super.viewDidLoad()
      weatherCollectionView.dataSource = self
      weatherCollectionView.delegate = self
    }
  
//  private func loadData() {
//    DarkSkyAPIClient.manager.getForecast(from: , completionHandler: <#T##(Result<[Forecast], AppError>) -> Void#>)
//  }
  
  
  

}


extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    <#code#>
  }
}


extension WeatherViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    zipcodeEntered = textField.text
    
//    loadData()
  }
}
