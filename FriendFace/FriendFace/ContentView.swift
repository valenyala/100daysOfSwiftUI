//
//  ContentView.swift
//  FriendFace
//
//  Created by Valentin Yang on 13/1/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    var body: some View {
        NavigationStack {
            Group {
                if users.isEmpty {
                    ProgressView()
                } else {
                    FFUserList(users: users)
                }
            }
            .task {
                await fetchData(from: "https://www.hackingwithswift.com/samples/friendface.json")
           }
        }
        .navigationTitle("FriendFace")
    }

    func fetchData(from urlString: String) async {
        print("Entering")
        guard let url = URL(string: urlString), users.isEmpty else {
            print("Not fetching")
            return
        }

        print("Fetching")
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodeUsers = try? JSONDecoder().decode([User].self, from: data) {
                for user in decodeUsers {
                    modelContext.insert(user)
                }
            }
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
        print("Exiting")
    }
}

#Preview {
    ContentView()
}
