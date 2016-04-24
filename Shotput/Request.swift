import UIKit

enum Method: Int {
    case GET = 1, POST, PUT, PATCH, DELETE, HEAD, OPTIONS
    static let allValues = [GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS]
}

class Header {
    let field: String
    let value: String
    
    init(field: String, value: String) {
        self.field = field
        self.value = value
    }
}
