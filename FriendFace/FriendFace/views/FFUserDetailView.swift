import SwiftUI

struct FFUserDetailView: View {
    var user: User
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "birthday.cake")
                    .background(.gray.opacity(0.2))
                VStack {
                    Text("Age: \(user.age)")
                }
            }

            HStack {
                Image(systemName: "envelope")
                    .background(.gray.opacity(0.2))
                VStack {
                    Text("Email: \(user.email)")
                }
            }

            Text("Tags")
                .font(.headline)
                .fontWeight(.semibold)
            List(user.tags, id: \.self) { tag in
                Text(tag)
            }
            .scrollContentBackground(.hidden)

            Text("Friends")
                .font(.title)
                .fontWeight(.semibold)

            List(user.friends) { friend in
                HStack {
                    Image(systemName: "person")
                    VStack(alignment: .leading) {
                        Text(friend.name)
                        Text(friend.id.uuidString)
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
        .padding()
        .navigationTitle(user.name)
    }
}
