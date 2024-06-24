import Foundation

@MainActor
final class PropertySearchProvider: Provider, ObservableObject {
    typealias Result = ([AreaModel], [PropertyModel])
    
    let service: any ServiceProtocol
    
    @Published 
    private(set) var area = [AreaModel]()
    
    @Published
    private(set) var properties = [PropertyModel]()
    
    @Published
    private(set) var error: ProviderError?
    
    @Published
    private(set) var isLoading = false
    
    init(_ downloader: HTTPDataDownloader = URLSession.shared) {
        self.service = PropertySearchService(downloader)
    }
    
    @Sendable
    func fetch() async -> Void {
        do {
            self.isLoading = true
            
            guard let (area, properties) = try await service.fetch() as? Result else {
                self.error = .missingData
                self.isLoading = false
                return
            }
            
            self.area = area
            self.properties = properties
            
            self.isLoading = false
        } catch {
            self.error = .unexpectedError(error: error)
            self.isLoading = false
        }
    }
}
