
import Foundation


struct Forecast: Codable {
//  let latitude: Double
//  let longitude: Double
  let daily: Daily
}

struct Daily: Codable {
//  let summary: String
//  let icon: String
  let data: [dataWrapper]
}

struct dataWrapper: Codable {
  let summary: String
  let time: Int
  let sunriseTime: Int
  let sunsetTime: Int
  let temperatureHigh: Double
  let temperatureLow: Double
  let windSpeed: Double
  let precipProbability: Double
  let icon: String
  
  func convertDate(time: Double) -> String {
    let exactDate = NSDate(timeIntervalSince1970: time)
    let dateFormatt = DateFormatter()
    let timeFormatt = DateFormatter()
    dateFormatt.dateFormat = "MM/dd/yyyy"
    timeFormatt.dateFormat = "hh:mm:ss a"
    return dateFormatt.string(from: exactDate as Date)
  }
  
  func convertTime(time: Double) -> String {
    let exactDate = NSDate(timeIntervalSince1970: time)
    let timeFormatt = DateFormatter()
    timeFormatt.dateFormat = "hh:mm a"
    return timeFormatt.string(from: exactDate as Date)
  }
}

