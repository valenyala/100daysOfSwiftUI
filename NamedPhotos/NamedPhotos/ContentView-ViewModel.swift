import Foundation

extension ContentView {
    @Observable
    class ViewModel {
        static let savedPath = URL.documentsDirectory.appendingPathComponent("photos")

        var photos: [Photo]

        init() {
            if let data = try? Data(contentsOf: Self.savedPath),
               let photos = try? JSONDecoder().decode([Photo].self, from: data) {
                self.photos = photos
            } else {
                photos = []
            }
        }

        func addPhoto(photo: Photo) {
            photos.append(photo)
            photos.sort()

            save()
        }

        func save() {
            do {
                let data = try JSONEncoder().encode(photos)
                try data.write(to: Self.savedPath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
    }
}
