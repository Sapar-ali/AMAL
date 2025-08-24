import SwiftUI

struct StatsView: View {
    @ObservedObject private var stats = StatsManager.shared

    var body: some View {
        List {
            Section("Статы") {
                ForEach(StatType.allCases, id: \.self) { stat in
                    HStack {
                        Text(stat.rawValue)
                        Spacer()
                        Text("\(stats.stats[stat, default: 0])")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}


