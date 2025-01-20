//
//  ContentView.swift
//  InstaFilter
//
//  Created by Valentin Yang on 15/1/25.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @State private var beginImage: CIImage?
    @State private var processedImage: Image?
    @State private var selectedItem: PhotosPickerItem?

    @State private var showingFilters = false

    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()

    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView(
                            "No picture",
                            systemImage: "photo.badge.plus",
                            description: Text("Tap to import a photo"))
                    }
                }
                .onChange(of: selectedItem, loadImage)
                Spacer()
                Group {
                    VStack {
                        if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                            HStack {
                                Text("Intensity")
                                    .foregroundColor(
                                        processedImage == nil ? .gray.opacity(0.5) : .black)
                                Slider(value: $filterIntensity)
                                    .onChange(of: filterIntensity, applyFilter)
                            }
                        }
                        if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                            HStack {
                                Text("Radius")
                                    .foregroundColor(
                                        processedImage == nil ? .gray.opacity(0.5) : .black)
                                Slider(value: $filterRadius)
                                    .onChange(of: filterRadius, applyFilter)
                            }
                        }
                        if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                            HStack {
                                Text("Scale")
                                    .foregroundColor(
                                        processedImage == nil ? .gray.opacity(0.5) : .black)
                                Slider(value: $filterScale)
                                    .onChange(of: filterScale, applyFilter)
                            }
                        }
                    }
                    HStack {
                        Button("Change Filter") {
                            showingFilters = true
                        }

                        Spacer()

                        if let processedImage {
                            ShareLink(
                                item: processedImage,
                                preview: SharePreview("InstaFilter image", image: processedImage)
                            )
                        }
                    }
                }
                .padding()
                .disabled(processedImage == nil)
            }
            .padding([.vertical, .bottom])
            .navigationTitle("InstaFilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {

                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Bloom") {setFilter(CIFilter.bloom())}
                Button("Comic Effect") {setFilter(CIFilter.comicEffect())}
                Button("Color Invert") {setFilter(CIFilter.colorInvert())}
                Button("Cancel", role: .cancel) {}
            }
        }
    }

    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {
                return
            }
            guard let inputImage = UIImage(data: imageData) else { return }

            beginImage = CIImage(image: inputImage)

            currentFilter.setValue(beginImage!, forKey: kCIInputImageKey)
            applyFilter()
        }
    }

    func applyFilter() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)
        }

        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return
        }

        let uiImage = UIImage(cgImage: cgImage)

        processedImage = Image(uiImage: uiImage)
    }

    @MainActor func setFilter(_ filter: CIFilter) {
        filterCount += 1

        if filterCount >= 20 {
            requestReview()
        }
        currentFilter = filter
        loadImage()
    }
}

#Preview {
    ContentView()
}
