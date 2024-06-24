extension API.Model {
    struct Area: Codable {
        let type: String
        let id: String
        let area: String
        let ratingFormatted: String
        let averagePrice: Int
        let image: String
    }
}

extension API.Model.Area {
    init?(_ item: API.Model.PropertyListing) {
        guard case .area(let area) = item else {
            return nil
        }
        
        self.type = area.type
        self.id = area.id
        self.area = area.area
        self.ratingFormatted = area.ratingFormatted
        self.averagePrice = area.averagePrice
        self.image = area.image
    }
}
