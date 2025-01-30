//
//  ContentView.swift
//  NamedPhotos
//
//  Created by Valentin Yang on 29/1/25.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    ForEach(viewModel.photos) { photo in
                        NavigationLink(destination: PhotoDetailView(photo: photo)) {
                            HStack {
                                Image(uiImage: getUIImage(from: photo.data))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 2)
                                    )
                                    .padding(.horizontal, 5)

                                Text(photo.name)
                                .foregroundColor(.primary)

                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Photos")
            .toolbar {
                NavigationLink(destination: AddPhotoView(onSave: viewModel.addPhoto)) {
                    Image(systemName: "plus")
                }
            }
        }
    }

    func getUIImage(from data: Data) -> UIImage {
        UIImage(data: data)!
    }
}

#Preview {
    ContentView()
}
