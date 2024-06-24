import NetworkExtension

extension API.Endpoint {
    struct PropertySearch {
        typealias T = ([API.Model.Area], [API.Model.Property])
        private typealias R = API.Model.PropertyListingContainer
        
        private let downloader: HTTPDataDownloader
        
        init(_ downloader: HTTPDataDownloader = URLSession.shared) {
            self.downloader = downloader
        }
        
        private var path: String {
            get throws {
                guard let baseURL = Environment.baseURL,
                      let path = Environment.searchPath else {
                    throw API.Endpoint.EndpointError.badPath
                }
                
                let urlString = "\(baseURL)\(path)"
                return urlString
            }
        }
        
        func fetch() async throws -> T {
            let urlString = try path
            let result: R = try await downloader.httpData(urlString)
            
            let properties = result.items.compactMap(API.Model.Property.init)
            let area = result.items.compactMap(API.Model.Area.init)
            
            if (area.isEmpty || properties.isEmpty) {
                throw API.Endpoint.EndpointError.conversionFailure
            }
            
            return (area, properties)
        }
    }
}
