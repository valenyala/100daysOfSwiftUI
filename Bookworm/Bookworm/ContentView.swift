//
//  ContentView.swift
//  Bookworm
//
//  Created by Valentin Yang on 9/1/25.
//

import Inject
import SwiftData
import SwiftUI

struct ContentView: View {
    @ObserveInjection var inject

    @Environment(\.modelContext) var modelContext
    @Query var books: [Book]

    @State private var showingAddScreen = false

    @State private var rating = 3
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        VStack(alignment: .leading) {
                            Text(book.title)
                                .font(.headline)
                                .foregroundColor(book.rating == 1 ? .red : .black)
                            Text(book.author)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationDestination(for: Book.self) { book in
                BookDetailView(book: book)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
        .enableInjection()
    }

    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(books[offset])
        }
    }
}

#Preview {
    ContentView()
}
