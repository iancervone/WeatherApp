import Foundation

struct Photo: Codable {
  let hits: [PhotoDetails]
  
  static func decodePhotosFromData(from jsonData: Data) throws -> Photo {
     let response = try JSONDecoder().decode(Photo.self, from: jsonData)
     return response
   }
}

struct PhotoDetails: Codable {
  let largeImageURL: String


}
