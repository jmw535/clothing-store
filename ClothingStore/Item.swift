import Foundation


// Create data structure for each item in the clothing list
struct MenuItem {
    var id: Int
    var name: String
    var description: String
    var price: Double
    var category: String
    var imageURL: URL
    
    struct PropertyKey {
        static let id = "id"
        static let name = "name"
        static let description = "description"
        static let price = "price"
        static let category = "category"
        static let imageURL = "image_url"
    }
    init?(json: [String: Any]) {
        guard let id = json[PropertyKey.id] as? Int,
            let name = json[PropertyKey.name] as? String,
            let description = json[PropertyKey.description] as?
            String,
            let price = json[PropertyKey.price] as? Double,
            let category = json[PropertyKey.category] as?
            String,
            let imageString = json[PropertyKey.imageURL] as?
            String,
            let imageURL = URL(string: imageString) else {
                return nil
        }
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.category = category
        self.imageURL = imageURL
    }
}
