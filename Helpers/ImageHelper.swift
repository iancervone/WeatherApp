
import Foundation
import UIKit

class ImageHelper {
    
  static let shared = ImageHelper()
    
  func getImage(urlStr: String, completionHandler: @escaping (Result<UIImage, AppError>) -> ()) {
    
    guard let url = URL(string: urlStr) else {
      completionHandler(.failure(.badURL))
      return
    }
    
    URLSession.shared.dataTask(with: url) { (data, _, error) in
      guard error == nil else {
        completionHandler(.failure(.badURL))
        return
      }
      
      guard let data = data else {
        completionHandler(.failure(.noDataReceived))
        return
      }
      
      guard let image = UIImage(data: data) else {
        completionHandler(.failure(.notAnImage))
        return
      }
      
      completionHandler(.success(image))
      }.resume()
  }
    
  private init() {}
}
