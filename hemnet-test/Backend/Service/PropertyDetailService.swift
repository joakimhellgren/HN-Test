final class PropertyDetailService: ServiceProtocol {
    typealias Result = PropertyModel?
    private let endpoint: API.Endpoint.PropertyDetail
    
    init(_ downloader: HTTPDataDownloader) {
        self.endpoint = .init(downloader)
    }
    
    func fetch() async throws -> Result {
        let item = try await endpoint.fetch()
        return try PropertyModel(item)
    }
}
