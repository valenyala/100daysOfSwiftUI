import MapKit
import LocalAuthentication

extension ContentView {
    @Observable
    class ViewModel {
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")

        var isUnlocked = false

        private(set) var locations: [Location]
        var selectedLocation: Location?

        var showUnlockFailedAlert = false
        var unlockFailedMessage = ""

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }

        func addLocation(at coordinate: CLLocationCoordinate2D) {
            let location = Location(
            id: UUID(),
            name: "Unknown",
            description: "You need to enter a description",
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
            )
            locations.append(location)

            save()
        }

        func updateLocation(_ location: Location) {
            guard let selectedPlace = selectedLocation else { return }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }

            save()
        }

        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }

        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, err in
                    if success {
                        self.isUnlocked = true
                    }
                    else {
                        if let err = err {
                            self.showUnlockFailedAlert = true
                            self.unlockFailedMessage = err.localizedDescription
                        }
                    }
                }
            } else {
                // there's no biometric authentication
                isUnlocked = true
            }
        }
    }
}
