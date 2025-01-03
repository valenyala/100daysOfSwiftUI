//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Valentin Yang on 1/1/25.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    var habits: HabitTracker
    @State private var name = ""
    @State private var description = ""
    var body: some View {
        VStack(spacing: 16) {
            TextField("Name", text: $name)
                .padding()
                .background(Color.lightGray)
                .clipShape(.rect(cornerRadius: 16))
            TextField("Description", text: $description, axis: .vertical)
                .lineLimit(3...5)
                .padding()
                .background(Color.lightGray)
                .clipShape(.rect(cornerRadius: 16))
            
            Button {
                appendHabit()
                dismiss()
            } label: {
                Label("Save", systemImage: "plus")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.lightGray)
                    .clipShape(.rect(cornerRadius: 16))
                    .foregroundStyle(.black)
                    .font(.headline.bold())
            }
            
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
            }
            ToolbarItem(placement: .principal, content: {
                Text("Add Habit")
                    .font(.title2.bold())
            })
        }
        .padding(.horizontal, 30)
        .padding(.vertical)
        Spacer()
    }
    
    func appendHabit() {
        guard !name.isEmpty else { return }
        let habit = Habit(name: name, description: description, timesCompleted: 0)
        habits.habits.append(habit)
    }
}

extension Color {
    static let lightGray = Color(red: 0.95, green: 0.95, blue: 0.95)
}

#Preview {
    NavigationStack {
        AddHabitView(habits: HabitTracker())
    }
}
