//
//  ContentView.swift
//  BucketList
//
//  Created by Valentin Yang on 20/1/25.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()

    @State private var mapModeIsStandard = true

    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    var body: some View {
        if viewModel.isUnlocked {
            ZStack(alignment: .topTrailing) {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .simultaneousGesture(
                                        LongPressGesture(minimumDuration: 1).onEnded { _ in
                                            viewModel.selectedLocation = location
                                        }
                                    )
                            }
                        }
                    }
                    .mapStyle(mapModeIsStandard ? .standard : .hybrid)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedLocation) { location in
                        EditMapView(location: location) { editedLocation in
                            viewModel.updateLocation(editedLocation)
                        }
                    }
                }

                Button("Change map style") {
                    mapModeIsStandard.toggle()
                }
                .padding()
                .foregroundStyle(.black)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white.opacity(0.4))
                        .blur(radius: 10)
                )
            }
        } else {
            Button("Unlock places") {
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.capsule)
            .alert("Unlock failed", isPresented: $viewModel.showUnlockFailedAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.unlockFailedMessage)
            }
        }
    }
}

#Preview {
    ContentView()
}
