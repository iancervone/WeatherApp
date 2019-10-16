
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
  
  
}




//let timestamp: NSNumber = (Date().timeIntervalSince1970 as AnyObject as! NSNumber)
//print(timestamp)  // 1524654473.108564
//let exactDate = NSDate(timeIntervalSince1970: TimeInterval(truncating: timestamp))
//let dateFormatt = DateFormatter()
//dateFormatt.dateFormat = "dd/MM/yyy hh:mm:ss a"
//print(dateFormatt.string(from: exactDate as Date)) //25/04/2018 04:37:53 PM
