import SwiftUI
import CoreImage.CIFilterBuiltins

struct AboutMeView: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "you@you.com"

    @State private var qrCode = UIImage()
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)

                    TextField("Email address", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .font(.title)

                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        let image = Image(uiImage: qrCode)

                        ShareLink(item: image, preview: SharePreview("My QR Code", image: image)) 
                    }
            }
            .navigationTitle("Your code")
            .onAppear(perform: updateQrCode)
            .onChange(of: name, updateQrCode)
            .onChange(of: emailAddress, updateQrCode)
        }
    }

    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }

    func updateQrCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
}
