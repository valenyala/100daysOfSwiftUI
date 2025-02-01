import MapKit
import SwiftUI

struct PhotoAddedLocation: View {
    @Environment(\.dismiss) private var dismiss
    let addedLocation: CLLocationCoordinate2D

    let initialRegion: MapCameraPosition

    init(addedLocation: CLLocationCoordinate2D) {
        self.addedLocation = addedLocation

        initialRegion = MapCameraPosition.region(
            MKCoordinateRegion(
                center: addedLocation,
                span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
            )
        )

    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(initialPosition: initialRegion) {
                Marker(coordinate: addedLocation) {

                }
            }

            Button("Cancel", role: .cancel) {
                dismiss()
            }
            .padding()
        }
    }
}
