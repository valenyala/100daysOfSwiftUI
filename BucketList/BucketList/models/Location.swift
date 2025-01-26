import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    #if DEBUG
        static let example = Location(
            id: UUID(),
            name: "London",
            description: "The home of Big Ben.",
            latitude: 51.5,
            longitude: 0.13
        )
    #endif

    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
