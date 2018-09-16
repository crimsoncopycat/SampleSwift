import Alamofire

enum Encoding {
    case string
    case json
}

enum ErrorType: Error {
    case connection
    case undefined
    case request(Error?)
    case responseParse
    var message : String {
        switch self {
        case .connection:
            return "Connection lost!"
        case .undefined:
            return "Something wrong!"
        case .request(let error):
            return "Error\(String(describing: error?.localizedDescription))"
        case .responseParse:
            return "Error parsing result!"
        }
    }
}
struct RequestInputs {
    let params: [String: Any]?
    let baseUrl: String
    let path: String
    let method: Alamofire.HTTPMethod
    let encoding: ParameterEncoding
    let onSuccess: (Any?) throws -> Void
    let onFailure: (ErrorType) -> Void
    
    init(params: [String: Any]? = nil,
         baseUrl: String,
         path: String = "",
         method: Alamofire.HTTPMethod = .get,
         encoding: ParameterEncoding = JSONEncoding.default,
         onSuccess: @escaping (Any?) throws -> Void,
         onFailure: @escaping (ErrorType) -> Void) {
        self.params = params
        self.path = path
        self.baseUrl = baseUrl
        self.method = method
        self.encoding = encoding
        self.onSuccess = onSuccess
        self.onFailure = onFailure
    }
}

struct Request {
    init(inputs: RequestInputs, encoding: Encoding) {
        if !Reachability.isConnectedToNetwork() {
            inputs.onFailure(.connection)
            
            return
        }
        guard let url = URL(string: inputs.baseUrl) else {
            inputs.onFailure(.undefined)
            
            return
        }
        
        switch encoding {
        case .string: stringRequest(with: inputs, url: url)
        case .json: jsonRequest(with: inputs, url: url)
        }
    }
    
    private func stringRequest(with inputs: RequestInputs, url: URL) {
        guard let url = URL(string: url.absoluteString + inputs.path) else {
            fatalError()
        }
        Alamofire.request(url,
                          method: inputs.method,
                          parameters: inputs.params,
                          encoding: inputs.encoding).responseString(encoding: .utf8, completionHandler: { (response) in
                            switch response.result {
                                
                            case .success: try? inputs.onSuccess(response.value)
                            case .failure: inputs.onFailure(.request(response.error))
                            }
                          })
    }
    
    private func jsonRequest(with inputs: RequestInputs, url: URL) {
        guard let url = URL(string: url.absoluteString + inputs.path) else {
            fatalError()
        }
        Alamofire.request(url,
                          method: inputs.method,
                          parameters: inputs.params,
                          encoding: inputs.encoding).responseJSON(completionHandler: { response in
                            switch response.result {
                            case .success: try? inputs.onSuccess(response.value)
                            case .failure: inputs.onFailure(.request(response.error))
                            }
                          })
    }
}
