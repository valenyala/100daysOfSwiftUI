import SwiftUI

struct PhotoDetailView: View {
    let photo: Photo
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: photo.data)!)
                .resizable()
                .scaledToFit()
        }
        .navigationTitle(photo.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
