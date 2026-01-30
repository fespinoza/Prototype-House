import SwiftUI

struct HabitsView: View {
    @State private var selectedWeek = 41
    @State private var selectedYear = 2025

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Sticky Week Selector
                WeekHeader(selectedWeek: $selectedWeek, selectedYear: $selectedYear)
                    .padding(.horizontal)
                    .padding(.top, 4)

                Divider()

                // Habit List
                VStack(spacing: 24) {
                    HabitRow(title: "📏 measure waist", completed: true)
                    HabitRow(title: "🧑‍🔬 Wash hair", completed: true)
                    HabitRow(title: "🇳🇴 Duolingo")
                    HabitRow(title: "📚 Read")
                    HabitRow(title: "🎬 YouTube")
                    HabitRow(title: "👩‍💻 Coding", completed: true)
                    HabitRow(title: "🍅 4 work pomodoros")
                    HabitRow(title: "✏️ Readwise")
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Habits")
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(.systemBackground), for: .navigationBar)
    }
}

struct WeekHeader: View {
    @Binding var selectedWeek: Int
    @Binding var selectedYear: Int

    var body: some View {
        HStack {
            Button {
                selectedWeek -= 1
            } label: {
                Image(systemName: "chevron.left")
            }

            Spacer()

            VStack(spacing: 2) {
                Text("Week \(selectedWeek)")
                    .font(.headline)
                Text("\(selectedYear)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                selectedWeek += 1
            } label: {
                Image(systemName: "chevron.right")
            }
        }
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .shadow(radius: 1, y: 1)
    }
}

struct HabitRow: View {
    var title: String
    var completed: Bool = false

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if completed {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

#Preview {
    NavigationStack {
        HabitsView()
    }
}
