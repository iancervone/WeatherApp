

import Foundation

struct DarkSkyAPIClient {

  static let manager = DarkSkyAPIClient()
  
  func getForecast(from coordinates: String, completionHandler: @escaping (Result<[Forecast], AppError>) -> Void) {
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
           let forecastInfo = try JSONDecoder().decode([Forecast].self, from: data)
           completionHandler(.success(forecastInfo))
         } catch {
           completionHandler(.failure(.couldNotParseJSON(rawError: error)))
         }
       }
     }
   }

  private init() {}
}


