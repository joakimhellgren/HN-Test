final class PropertySearchService: ServiceProtocol {
    typealias Result = ([AreaModel], [PropertyModel])
    private let endpoint: API.Endpoint.PropertySearch
    
    init(_ downloader: HTTPDataDownloader) {
        self.endpoint = .init(downloader)
    }
    
    func fetch() async throws -> Result {
        let data = try await endpoint.fetch()
        let area = try data.0.map(AreaModel.init)
        let property = try data.1.map(PropertyModel.init)
        return (area, property)
    }
}

