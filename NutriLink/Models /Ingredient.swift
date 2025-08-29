import Foundation

struct Ingredient: Identifiable, Codable, Hashable {
    let id = UUID()
    var name: String
    var quantity: String
}
