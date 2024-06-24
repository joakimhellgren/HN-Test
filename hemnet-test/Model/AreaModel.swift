struct AreaModel: Identifiable, Hashable, Equatable, Codable {
    let type: String
    let id: String
    let area: String
    let ratingFormatted: String
    let averagePrice: Int
    let image: String
}

extension AreaModel {
    init(_ model: API.Model.Area) throws {
        self.init(type: model.type,
                  id: model.id,
                  area: model.area,
                  ratingFormatted: model.ratingFormatted,
                  averagePrice: model.averagePrice,
                  image: model.image)
    }
}

#if DEBUG
extension AreaModel {
    static var preview = AreaModel(type: "Area",
                                   id: "1234567892",
                                   area: "Stockholm",
                                   ratingFormatted: "4.5/5",
                                   averagePrice: 50100,
                                   image: "https://i.imgur.com/v6GDnCG.png")
}
#endif
