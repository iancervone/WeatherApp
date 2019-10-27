
import Foundation

class UserDefaultsWrapper {
  static let wrapper = UserDefaultsWrapper()

  
  func getUserZip() -> String? {
    return UserDefaults.standard.value(forKey: zipKey) as? String
  }

  
  func storeUserZip(zip: String) {
    UserDefaults.standard.set(zip, forKey: zipKey)
  }
  
  
  private let zipKey = "zip"

  private init() {}
}


