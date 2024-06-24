import Foundation

extension API.Model {
    struct PropertyListingContainer: Codable {
        let items: [API.Model.PropertyListing]
    }
    
    enum PropertyListing: Codable {
        case property(API.Model.Property)
        case area(API.Model.Area)
        
        enum CodingKeys: String, CodingKey {
            case type
        }
        
        enum ItemType: String, Codable {
            case highlightedProperty = "HighlightedProperty"
            case property = "Property"
            case area = "Area"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(ItemType.self, forKey: .type)
            
            switch type {
            case .property, .highlightedProperty:
                let value = try API.Model.Property(from: decoder)
                self = .property(value)
            case .area:
                let value = try API.Model.Area(from: decoder)
                self = .area(value)
            }
        }
        
        func encode(to encoder: Encoder) throws {
            switch self {
            case .property(let value):
                try value.encode(to: encoder)
            case .area(let value):
                try value.encode(to: encoder)
            }
        }
    }
}
