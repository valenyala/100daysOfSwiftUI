//
//  HabitsListView.swift
//  HabitTracker
//
//  Created by Valentin Yang on 1/1/25.
//

import SwiftUI

struct HabitsListView: View {
    @State private var habits = HabitTracker()
    var body: some View {
        VStack {
            if habits.habits.isEmpty {
                Text("No habits yet. Add one!")
            }
            ForEach(habits.habits) { habit in
                HStack {
                    VStack(alignment: .leading) {
                        Text(habit.name)
                            .font(.headline)
                        Text("completed \(habit.timesCompleted) time(s)")
                    }
                    Spacer()
                    Button {
                        markCompleted(habit: habit)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
            }
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink {
                    AddHabitView(habits: habits)
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.black)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Habits")
                    .font(.title.bold())
            }
        }
    }
    
    func markCompleted(habit: Habit) {
        if let index = habits.habits.firstIndex(where: { $0.id == habit.id }) {
            habits.habits[index].timesCompleted += 1
        }
    }
}

#Preview {
    NavigationStack {
        HabitsListView()
    }
}
