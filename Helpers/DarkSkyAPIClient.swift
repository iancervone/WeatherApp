

import Foundation

struct DarkSkyAPIClient {

  static let manager = DarkSkyAPIClient()
  
  func getForecast(from latLong: String, completionHandler: @escaping (Result<[Forecast], AppError>) -> Void) {
     let forecastURL = "https://api.darksky.net/forecast/\(latLong)/37.8267,-122.4233"
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
