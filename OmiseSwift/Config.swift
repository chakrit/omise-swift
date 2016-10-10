import Foundation

open class Config: NSObject {
    open let apiVersion: String?
    open let publicKey: String?
    open let secretKey: String?
    
    open let callbackQueue: OperationQueue

    public let pinningSignature: Data?

    public convenience init(secretKey: String) {
        self.init(publicKey: nil, secretKey: secretKey, apiVersion: nil, queue: nil)
    }
    
    public convenience init(publicKey: String, secretKey: String) {
        self.init(publicKey: publicKey, secretKey: secretKey, apiVersion: nil, queue: nil)
    }
    
    public init(publicKey: String?, secretKey: String?, apiVersion: String?, queue: OperationQueue? = nil, pinningSignature: Data? = nil) {
        self.publicKey = publicKey
        self.secretKey = secretKey
        self.apiVersion = apiVersion
        self.callbackQueue = queue ?? OperationQueue.main
        self.pinningSignature = pinningSignature
    }
    
    func apiKey(forHost host: String) -> String? {
        let key: String?
        if host.contains("vault.omise.co") {
            key = publicKey
        } else {
            key = secretKey
        }
        
        return key
    }
}
