import Foundation

final class StatsManager: ObservableObject {
    static let shared = StatsManager()
    @Published private(set) var stats: [StatType: Int] = {
        var dict: [StatType: Int] = [:]
        StatType.allCases.forEach { dict[$0] = 0 }
        return dict
    }()

    private init() {}

    func add(_ points: Int, to stat: StatType) {
        stats[stat, default: 0] += points
    }
}


