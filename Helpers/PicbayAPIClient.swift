
import Foundation

struct PicbayAPIClient {
    
  static let manager = PicbayAPIClient()
  
  
  func getPhotos(from location: String, completionHandler: @escaping (Result<[PhotoDetails], AppError>) -> ())  {
    guard let photoURL = URL(string: "https://pixabay.com/api/?key=13808200-81ee63e0877b0001abe64bfd1&q=\(location)") else {
      fatalError()
    }
    NetworkHelper.manager.getData(from: photoURL) { result in
      switch result {
      case .failure(let error):
        completionHandler(.failure(error))
      case .success(let data):
        do {
          let photoInfo = try JSONDecoder().decode(Photo.self, from: data)
          completionHandler(.success(photoInfo.hits))
        }
        catch {
          completionHandler(.failure(.couldNotParseJSON(rawError: error)))
        }
      }
    }
  }
  
    
  
  private init() {}
}
