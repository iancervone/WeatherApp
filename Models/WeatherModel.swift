
import Foundation


struct Forecast: Codable {
  let latitude: Double
  let longitude: Double
  let daily: Daily
}

struct Daily: Codable {
  let summary: String
  let icon: String
  let data: [dataWrapper]
}

struct dataWrapper: Codable {
  let time: Int
  let sunriseTime: Int
  let sunsetTime: Int
  let temperatureHigh: Double
  let temperatureLow: Double
  let windSpeed: Double
  let icon: String
  
  func convertTime(time: Double) -> String {
    let exactDate = NSDate(timeIntervalSince1970: time)
    let dateFormatt = DateFormatter()
    let timeFormatt = DateFormatter()
    dateFormatt.dateFormat = "MM/dd/yyyy"
    timeFormatt.dateFormat = "a"
    return dateFormatt.string(from: exactDate as Date)
  }
  
  func dayOrNight(time: Double) -> String {
    let exactDate = NSDate(timeIntervalSince1970: time)
    let timeFormatt = DateFormatter()
    timeFormatt.dateFormat = "a"
    return timeFormatt.string(from: exactDate as Date)
  }
}

