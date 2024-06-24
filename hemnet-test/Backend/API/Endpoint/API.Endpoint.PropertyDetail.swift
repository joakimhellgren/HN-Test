import NetworkExtension

extension API.Endpoint {
    struct PropertyDetail {
        typealias T = API.Model.Property
        
        private typealias R = API.Model.PropertyListing
        private let downloader: HTTPDataDownloader
        
        init(_ downloader: HTTPDataDownloader = URLSession.shared) {
            self.downloader = downloader
        }
        
        private var path: String {
            get throws {
                guard let baseURL = Environment.baseURL,
                      let path = Environment.detailPath else {
                    throw API.Endpoint.EndpointError.badPath
                }
                
                let urlString = "\(baseURL)\(path)"
                return urlString
            }
        }
        
        func fetch() async throws -> T {
            do {
                let urlString = try path
                let data: R = try await downloader.httpData(urlString)
                
                guard let convertedData = T(data) else {
                    throw API.Endpoint.EndpointError.conversionFailure
                }
                
                return convertedData
            }
        }
    }
}
