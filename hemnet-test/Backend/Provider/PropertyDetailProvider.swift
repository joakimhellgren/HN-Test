import Foundation

@MainActor
final class PropertyDetailProvider: Provider, ObservableObject {
    typealias Result = PropertyModel?
    let service: any ServiceProtocol
    
    @Published
    private(set) var item: PropertyModel?
    
    @Published
    private(set) var error: ProviderError?
    
    @Published
    private(set) var isLoading = false
    
    init(_ downloader: HTTPDataDownloader = URLSession.shared) {
        self.service = PropertyDetailService(downloader)
    }
    
    @Sendable
    func fetch() async -> Void {
        do {
            self.isLoading = true
            
            guard let item = try await service.fetch() as? Result else {
                self.error = .missingData
                self.isLoading = false
                return
            }
            
            self.item = item
            
            self.isLoading = false
        } catch {
            self.error = .unexpectedError(error: error)
            self.isLoading = false
        }
    }
}
