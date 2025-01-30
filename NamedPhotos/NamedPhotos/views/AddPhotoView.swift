import PhotosUI
import SwiftUI

struct AddPhotoView: View {
    @Environment(\.dismiss) private var dismiss

    let onSave: (Data, String) -> Void
    @State private var pickerItem: PhotosPickerItem?
    @State private var imageToAddData: Data?
    @State private var imageToAdd: Image?

    @State private var name = ""

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
                        onSave(imageToAddData!, name)
                        dismiss()
                    }
                    .disabled(name.isEmpty || imageToAdd == nil)
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
        AddPhotoView { data, name in

        }
    }
}
