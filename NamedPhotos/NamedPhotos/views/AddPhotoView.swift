import PhotosUI
import SwiftUI

struct AddPhotoView: View {
    @Environment(\.dismiss) private var dismiss

    let onSave: (Photo) -> Void
    @State private var pickerItem: PhotosPickerItem?
    @State private var imageToAddData: Data?
    @State private var imageToAdd: Image?

    @State private var name = ""

    let locationFetcher = LocationFetcher()

    init(onSave: @escaping (Photo) -> Void) {
        self.onSave = onSave
        locationFetcher.start()
    }

    @State private var showNoLocationAlert = false
    @State private var noLocationAlertTitle = "We can't get your location, please try again."

    var body: some View {
        VStack {
            PhotosPicker(selection: $pickerItem) {
                if let imageToAdd {
                    imageToAdd
                        .resizable()
                        .scaledToFit()
                } else {
                    ContentUnavailableView(
                        "No picture",
                        systemImage: "photo.badge.plus",
                        description: Text("Tap to import a photo"))
                }
            }
            .onChange(of: pickerItem, loadImage)

            if imageToAdd != nil {
                TextField("Give this photo a name", text: $name)
                    .padding(5)
                    .clipShape(.rect(cornerRadius: 5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                    .padding()

                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            if imageToAdd != nil {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        guard let location = locationFetcher.lastKnownLocation else {
                            showNoLocationAlert = true
                            return
                        }
                        let photo = Photo(data: imageToAddData!, name: name, location: location)
                        onSave(photo)
                        dismiss()
                    }
                    .disabled(name.isEmpty || imageToAdd == nil)
                    .alert(noLocationAlertTitle, isPresented: $showNoLocationAlert) {
                        Button("Cancel", role: .cancel) {

                        }
                    }
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Add a photo")
                .font(.title2.bold())
            }
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }

    func loadImage() {
        Task {
            guard let pickedImageData = try? await pickerItem?.loadTransferable(type: Data.self)
            else { return }

            guard let uiImage = UIImage(data: pickedImageData) else { return }

            imageToAddData = pickedImageData
            imageToAdd = Image(uiImage: uiImage)
        }
    }
}

#Preview {
    NavigationStack {
        AddPhotoView { photo in

        }
    }
}
