import Foundation

public enum Endpoint: String {
    case Vault = "https://vault.omise.co"
    case API = "https://api.omise.co"
    
    var url: URL {
        guard let url = URL(string: rawValue) else {
            NSLog("error building endpoint url from: \(rawValue)")
          return URL(string: "")!
        }
        
        return url
    }
}
