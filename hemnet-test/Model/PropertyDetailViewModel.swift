import Foundation

@MainActor
final class PropertyDetailViewModel: ObservableObject {
    let item: PropertyModel
    
    @Published
    private(set) var description: String? {
        didSet { item.description = description }
    }
    
    @Published
    private(set) var patio: String? {
        didSet { item.patio = patio }
    }
    
    init(item: PropertyModel) {
        self.item = item
        self.description = item.description
        self.patio = item.patio
    }
    
    func update(_ newItem: PropertyModel?) {
        description = newItem?.description
        patio = newItem?.patio
    }
}
