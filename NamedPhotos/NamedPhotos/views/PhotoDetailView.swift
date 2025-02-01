import SwiftUI

struct PhotoDetailView: View {
    let photo: Photo
    @State private var showLocation = false
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: photo.data)!)
                .resizable()
                .scaledToFit()

                Button("Show location") {
                    showLocation.toggle()
                }
                .sheet(isPresented: $showLocation) {
                    PhotoAddedLocation(addedLocation: photo.location)
                }
        }
        .navigationTitle(photo.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
