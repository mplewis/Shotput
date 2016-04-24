import UIKit

enum Method: Int {
    case GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS
    static let allValues = [GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS]
    static func fromRaw(raw: Int) -> Method? {
        return Method.init(rawValue: raw)
    }
}

class Header {
    let field: String
    let value: String
    
    init(field: String, value: String) {
        self.field = field
        self.value = value
    }
}

class Request: CustomStringConvertible {
    let method: Method
    let headers: [Header]?
    let url: NSURL
    let followRedirects: Bool
    
    init(method: Method, headers: [Header]?, url: NSURL, followRedirects: Bool) {
        self.method = method
        self.headers = headers
        self.url = url
        self.followRedirects = followRedirects
    }
    
    var description: String {
        return "Request: \(method) \(url) (headers: \(headers?.count), follow redirects: \(followRedirects))"
    }
}
