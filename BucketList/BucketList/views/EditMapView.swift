import SwiftUI

struct EditMapView: View {

    @Environment(\.dismiss) var dismiss

    @State private var viewModel: ViewModel

    var onSave: (Location) -> Void

    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave

        self._viewModel = State(initialValue: ViewModel(location: location))
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }

                Section("Nearby…") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageId) { page in
                            Text(page.title).font(.headline) + Text(": ")
                                + Text(page.description).italic()
                        }
                    case .loading:
                        HStack {

                            ProgressView()
                            Text("Loading…").foregroundColor(.secondary)
                        }
                    case .failed:
                        Text("Loading failed, please try again later")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description

                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }

}

#Preview {
    EditMapView(location: .example) { _ in }
}
