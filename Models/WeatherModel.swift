//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Ian Cervone on 10/14/19.
//  Copyright © 2019 Ian Cervone. All rights reserved.
//

import Foundation


struct Forecast: Codable {
  let latitude: Double
  let longitude: Double
  let daily: Daily
}

struct Daily: Codable {
  let summary: String
  let icon: String
  let data: Data
}

struct Data: Codable {
  let sunriseTime: Int
  let sunsetTime: Int
  let temperatureHigh: Double
  let temperatureLow: Double
  let windSpeed: Double
}

