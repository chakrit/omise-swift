import Foundation

open class Request<TResult: OmiseObject>: NSObject {
    public typealias Op = Operation<TResult>
    
    open let client: Client
    open let operation: Op
    open let callback: Op.Callback?
    
    public init(client: Client, operation: Op, callback: Op.Callback?) {
        self.client = client
        self.operation = operation
        self.callback = callback
        super.init()
    }
    
    static func buildURLRequest(_ config: Config, operation: Op) throws -> URLRequest {
        guard let host = operation.url.host else {
            throw OmiseError.unexpected("requested operation has invalid url.")
        }
        
        let apiKey = try selectAPIKey(config, host: host)
        let auth = try encodeApiKeyForAuthorization(apiKey)
        
        let request = NSMutableURLRequest(url: operation.url as URL)
        request.httpMethod = operation.method
        request.cachePolicy = .useProtocolCachePolicy
        request.timeoutInterval = 6.0
        request.addValue(auth, forHTTPHeaderField: "Authorization")
        
        guard !(request.httpMethod == "GET" && operation.payload != nil) else {
            omiseWarn("ignoring payloads for HTTP GET operation.")
            return request as URLRequest
        }
        
        request.httpBody = operation.payload
        return request as URLRequest
    }
    
    static func selectAPIKey(_ config: Config, host: String) throws -> String {
        let key: String?
        if host.contains("vault.omise.co") {
            key = config.publicKey
        } else {
            key = config.secretKey
        }
        
        guard let resolvedKey = key else {
            throw OmiseError.configuration("no api key for host \(host).")
        }
        
        return resolvedKey
    }
    
    static func encodeApiKeyForAuthorization(_ apiKey: String) throws -> String {
        let data = "\(apiKey):X".data(using: String.Encoding.utf8)
        guard let md5 = data?.base64EncodedString(options: .lineLength64Characters) else {
            throw OmiseError.configuration("bad API key (encoding failed.)")
        }
        
        return "Basic \(md5)"
    }
    
    
    func start() throws -> Self {
        let urlRequest = try Request.buildURLRequest(client.config, operation: operation)
        let dataTask = client.session.dataTask(with: urlRequest, completionHandler: didComplete)
        dataTask.resume()
        return self
    }
    
    fileprivate func didComplete(_ data: Data?, response: URLResponse?, error: Error?) {
        // no one's in the forest to hear the leaf falls.
        guard callback != nil else { return }
        
        if let err = error {
            return performCallback(.fail(.io(err as NSError)))
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return performCallback(.fail(.unexpected("no error and no response.")))
        }
        
        guard let data = data else {
            return performCallback(.fail(.unexpected("empty response.")))
        }
        
        do {
            switch httpResponse.statusCode {
            case 400..<600:
                let err: APIError = try OmiseSerializer.deserialize(data)
                return performCallback(.fail(.api(err)))
                
            case 200..<300:
                let result: TResult = try OmiseSerializer.deserialize(data)
                if let resource = result as? ResourceObject {
                    resource.attachedClient = client
                }
                
                return performCallback(.success(result))
                
            default:
                return performCallback(.fail(.unexpected("unrecognized HTTP status code: \(httpResponse.statusCode)")))
            }
            
        } catch let err as NSError {
            return performCallback(.fail(.io(err)))
        } catch let err as OmiseError {
            return performCallback(.fail(err))
        }
    }
    
    fileprivate func performCallback(_ result: Failable<TResult>) {
        guard let cb = callback else { return }
        client.performCallback { cb(result) }
    }
}
