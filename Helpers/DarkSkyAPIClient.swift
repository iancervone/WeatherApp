

import Foundation

struct DarkSkyAPIClient {

  static let manager = DarkSkyAPIClient()
  
  func getForecast(from coordinates: String, completionHandler: @escaping (Result<[dataWrapper], AppError>) -> Void) {
    // what we want to return as a result is an array of dataWrapper ^^^ because the info we need is that array of each set of info on the weather for that day
     let forecastURL = "https://api.darksky.net/forecast/15f4a2013db1f1490f3d5edf55166c5c/\(coordinates)"
     guard let url = URL(string: forecastURL) else {
       completionHandler(.failure(.badURL))
       return
     }
     NetworkHelper.manager.getData(from: url) { result in
       switch result {
       case .failure(let error) :
         completionHandler(.failure(error))
       case .success(let data):
         do {
          let forecastInfo = try JSONDecoder().decode(Forecast.self, from: data)
          //what we decode is a Forecast, not an array of dataWrapper ^^^ because we always decode from the highest level of the model
          completionHandler(.success(forecastInfo.daily.data))
         } catch {
           completionHandler(.failure(.couldNotParseJSON(rawError: error)))
         }
       }
     }
   }

  private init() {}
}


