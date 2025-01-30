import Foundation

struct Photo: Identifiable, Codable, Comparable {
    var id = UUID()
    var data: Data
    var name: String

    static func < (lhs: Photo, rhs: Photo) -> Bool {
        lhs.name < rhs.name
    }
}
