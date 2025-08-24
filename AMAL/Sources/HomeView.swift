import SwiftUI

struct HomeView: View {
    @State private var steps: Int = 0
    @State private var authorized = false

    var body: some View {
        NavigationStack {
            List {
                Section("Сегодня") {
                    HStack {
                        Text("Квест: 6 000 шагов")
                        Spacer()
                        Text("\(steps)")
                            .foregroundStyle(.secondary)
                    }
                    Text("Секрет: 5 минут тишины")
                }
            }
            .navigationTitle("AMAL")
            .task {
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


