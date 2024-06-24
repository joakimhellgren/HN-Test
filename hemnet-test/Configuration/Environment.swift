import Foundation

struct Environment {
    enum APIKey: String {
        case baseURL = "API_BASE_URL"
        case searchPath = "API_SEARCH_SERVICE_PATH"
        case detailPath = "API_DETAIL_SERVICE_PATH"
        
        var key: String { rawValue }
    }
    
    static var baseURL: String? {
        Bundle.main.infoDictionary?[APIKey.baseURL.key] as? String
    }
    
    static var searchPath: String? {
        Bundle.main.infoDictionary?[APIKey.searchPath.key] as? String
    }
    
    static var detailPath: String? {
        Bundle.main.infoDictionary?[APIKey.detailPath.key] as? String
    }
}
