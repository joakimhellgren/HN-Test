extension API.Model {
    struct Property: Codable {
        let type: String
        let id: String
        let askingPrice: Int
        let monthlyFee: Int?
        let municipality: String
        let area: String
        let daysSincePublish: Int
        let livingArea: Int
        let numberOfRooms: Int
        let streetAddress: String
        let image: String
        let description: String?
        let patio: String?
    }
}

extension API.Model.Property {
    init?(_ item: API.Model.PropertyListing) {
        guard case .property(let property) = item else{
            return nil
        }
        
        self.type = property.type
        self.id = property.id
        self.askingPrice = property.askingPrice
        self.monthlyFee = property.monthlyFee
        self.municipality = property.municipality
        self.area = property.area
        self.daysSincePublish = property.daysSincePublish
        self.livingArea = property.livingArea
        self.numberOfRooms = property.numberOfRooms
        self.streetAddress = property.streetAddress
        self.image = property.image
        self.description = property.description ?? nil
        self.patio = property.patio ?? nil
    }
}
