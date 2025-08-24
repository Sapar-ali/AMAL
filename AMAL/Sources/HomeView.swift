import SwiftUI

struct HomeView: View {
    @State private var steps: Int = 0
    @State private var authorized = false
    @State private var hasCalendarTime = false
    @ObservedObject private var quests = QuestManager.shared

    var body: some View {
        NavigationStack {
            List {
                Section("Сегодня") {
                    ForEach(quests.today) { quest in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(quest.title)
                                Text(quest.details)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            if quest.kind == .steps {
                                Text("\(steps)")
                                    .foregroundStyle(.secondary)
                            }
                            Button(quest.isCompleted ? "Готово" : "Выполнено") {
                                quests.complete(quest)
                            }
                            .buttonStyle(.bordered)
                            .disabled(quest.isCompleted)
                        }
                    }
                }
            }
            .navigationTitle("AMAL")
            .task {
                if quests.today.isEmpty {
                    quests.generateForToday(hasCalendarTime: hasCalendarTime)
                }
                if !authorized {
                    HealthKitManager.shared.requestAuthorization { ok in
                        authorized = ok
                        if ok {
                            HealthKitManager.shared.fetchTodayStepCount { value in
                                steps = Int(value)
                            }
                        }
                    }
                }
            }
        }
    }
}


