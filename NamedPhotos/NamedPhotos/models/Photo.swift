import Foundation
import CoreLocation

struct Photo: Identifiable, Codable, Comparable {
    var id = UUID()
    var data: Data
    var name: String
    var latitude: Double
    var longitude: Double

    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(data: Data, name: String, location: CLLocationCoordinate2D) {
        self.data = data
        self.name = name
        self.latitude = location.latitude
        self.longitude = location.longitude
    }

    static func < (lhs: Photo, rhs: Photo) -> Bool {
        lhs.name < rhs.name
    }
}
