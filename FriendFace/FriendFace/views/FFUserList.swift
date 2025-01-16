import SwiftUI

struct FFUserList: View {
    var users: [User]
    var body: some View {
        List(users) { user in
            NavigationLink(destination: FFUserDetailView(user: user)) {
                HStack {
                    Image(systemName: "person")

                        VStack(alignment: .leading) {
                            Text("\(user.name), age \(user.age)")
                                .font(.headline)
                                Text(user.isActive ? "Active" : "Inactive")
                                .font(.subheadline)
                                .foregroundColor(user.isActive ? .green : .red)
                        }
                }
            }
        }
    }
}

#Preview {
    // mock fake users
    let users = [
        User(id: UUID(), isActive: true, name: "John Doe", age: 22, company: "htuensa", email: "johndoe@gmali.com", address: "Someaddrr", about: "htuens", registered: .now, tags: ["hey", "sup!"], friends: [])
        ]

        FFUserList(users: users)
}
