

import UIKit
import Foundation

class WeatherViewController: UIViewController {
    
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var zipcodeTextField: UITextField!
  @IBOutlet weak var weatherCollectionView: UICollectionView!
  
  
  var forecast = [dataWrapper]() {
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
  
  
  var cityName: String? {
    didSet {
      weatherCollectionView.reloadData()
      setlocationLabel()
    }
  }
  
  
  override func viewDidLoad() {
      super.viewDidLoad()
      weatherCollectionView.dataSource = self
      weatherCollectionView.delegate = self
      zipcodeTextField.delegate = self
    }
  
  
//  private func setBackground() {
//    let dayNight = forecast.dayOrNight(time: Double(forecast.time))
//
//  }
  
  
  private func setlocationLabel() {
    locationLabel.text = "\(cityName!)'s Weekly Forecast"
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
              case let .success(forecastData):
                self!.forecast = forecastData
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
  }
  
  
  func displayErrorAlert(with error: AppError) {
    let alertVC = UIAlertController(title: "Error Fetching Data", message: "\(error)", preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
    present(alertVC, animated: true, completion: nil)
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailWeatherVC" {
            let destinationVC = segue.destination as! DetailWeatherViewController
            let cell = sender as! UICollectionViewCell
            let indexPaths = self.weatherCollectionView.indexPath(for: cell)
            destinationVC.dailyForecast = forecast[indexPaths!.row]
            destinationVC.city = cityName!
        }
    }
  
  
  

}


extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return forecast.daily.data.count
    return forecast.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell else {
      fatalError("expectd WeatherCollectionViewCEll but got something else")
    }
    let weather = forecast[indexPath.row]
    let date = weather.convertDate(time: Double(weather.time))
    cell.cellDateLabel.text = "\(date)"
    cell.cellHighLabel.text = "\(Int(weather.temperatureHigh)) °F"
    cell.cellLowLabel.text = "\(Int(weather.temperatureLow)) °F"
    cell.cellWeatherIcon.image = UIImage(named: "\(weather.icon)")
    return cell
  }
}


extension WeatherViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 165, height: 230)
  }
}


extension WeatherViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        zipcodeEntered = textField.text
        getLatLong()
        zipcodeTextField.resignFirstResponder()
    return true
  }
}
