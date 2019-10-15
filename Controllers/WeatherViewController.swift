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
  @IBAction func zipcodeTextField(_ sender: UITextField) {
  }
  @IBOutlet weak var weatherCollectionView: UICollectionView!
  
  
  
  var forecast = [Forecast]() {
    didSet {
      weatherCollectionView.reloadData()
    }
  }
    
  
  override func viewDidLoad() {
        super.viewDidLoad()
    }
  

}


//you can change the zipcode function to give you the city name too
static func getLatLong(fromZipCode zipCode: String, completionHandler: @escaping (Result<(lat: Double, long: Double,name:String), LocationFetchingError>) -> Void) {
      let geocoder = CLGeocoder()
      DispatchQueue.global(qos: .userInitiated).async {
          geocoder.geocodeAddressString(zipCode){(placemarks, error) -> Void in
              DispatchQueue.main.async {
                  if let placemark = placemarks?.first, let coordinate = placemark.location?.coordinate, let name = placemark.locality  {
                      completionHandler(.success((coordinate.latitude, coordinate.longitude,name)))
                  } else {
                      let locationError: LocationFetchingError
                      if let error = error {
                          locationError = .error(error)
                      } else {
                          locationError = .noErrorMessage
                      }
                      completionHandler(.failure(locationError))
                  }
              }
          }
      }
  }
