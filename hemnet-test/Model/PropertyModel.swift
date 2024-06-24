import Foundation

class PropertyModel: Identifiable, Equatable, Codable {
    var type: String
    var id: String
    var askingPrice: Int
    var municipality: String
    var area: String
    var daysSincePublish: Int
    var livingArea: Int
    var numberOfRooms: Int
    var streetAddress: String
    var image: String
    
    var monthlyFee: Int?
    var description: String?
    var patio: String?
    
    init(
        type: String,
        id: String,
        askingPrice: Int,
        municipality: String,
        area: String,
        daysSincePublish: Int,
        livingArea: Int,
        numberOfRooms: Int,
        streetAddress: String,
        image: String,
        monthlyFee: Int? = nil,
        description: String? = nil,
        patio: String? = nil
    ) {
        self.type = type
        self.id = id
        self.askingPrice = askingPrice
        self.monthlyFee = monthlyFee
        self.municipality = municipality
        self.area = area
        self.daysSincePublish = daysSincePublish
        self.livingArea = livingArea
        self.numberOfRooms = numberOfRooms
        self.streetAddress = streetAddress
        self.image = image
        self.description = description
        self.patio = patio
    }

}

extension PropertyModel {
    convenience init(_ model: API.Model.Property) throws {
        self.init(
            type: model.type,
            id: model.id,
            askingPrice: model.askingPrice,
            municipality: model.municipality,
            area: model.area,
            daysSincePublish: model.daysSincePublish,
            livingArea: model.livingArea,
            numberOfRooms: model.numberOfRooms,
            streetAddress: model.streetAddress,
            image: model.image,
            monthlyFee: model.monthlyFee,
            description: model.description,
            patio: model.patio
        )
    }
}

extension PropertyModel: Hashable {
    static func == (lhs: PropertyModel, rhs: PropertyModel) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id); hasher.combine(id) }
}

#if DEBUG
extension PropertyModel {
    static var preview = PropertyModel(
        type: "Property",
        id: "1234567893",
        askingPrice: 1150000,
        municipality: "Uppsala kommun",
        area: "Kvarngärdet",
        daysSincePublish: 12,
        livingArea: 29,
        numberOfRooms: 1,
        streetAddress: "Mockvägen 4",
        image: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Bertha_Petterssons_hus_01.jpg/800px-Bertha_Petterssons_hus_01.jpg",
        monthlyFee: 2298
    )
}
#endif

