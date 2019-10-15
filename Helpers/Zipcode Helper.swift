//
//  Zipcode Helper.swift
//  WeatherApp
//
//  Created by Ian Cervone on 10/15/19.
//  Copyright © 2019 Ian Cervone. All rights reserved.
//

import Foundation

import UIKit
import CoreLocation
enum LocationFetchingError: Error {
    case error(Error)
    case noErrorMessage
}
class ZipCodeHelper {
    private init() {}
  static func getLatLong(fromZipCode zipCode: String, completionHandler: @escaping (Result<(lat: Double, long: Double, name: String), Error>) -> Void) {
        let geocoder = CLGeocoder()
        DispatchQueue.global(qos: .userInitiated).async {
            geocoder.geocodeAddressString(zipCode){(placemarks, error) -> Void in
                DispatchQueue.main.async {
                    if let placemark = placemarks?.first, let coordinate = placemark.location?.coordinate, let name = placemark.locality {
                        completionHandler(.success((coordinate.latitude, coordinate.longitude, name)))
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
  
  
}


//var latLong = String {
//ZipCodeHelper.getLatLong(fromZipCode: "60613") { (result) in
//    switch result {
//    case let .success((lat, long, name)):
//        return(lat, long, name)
//    case let .failure(error):
//        print(error)
//    }
//  }
//}()


//ZipCodeHelper.getLatLong(fromZipCode: "60613") { (result) in
//    switch result {
//    case let .success((lat, long, name)):
//        print(lat, long)
//    case let .failure(error):
//        print(error)
//    }
//}