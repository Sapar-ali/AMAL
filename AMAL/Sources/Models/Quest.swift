import Foundation

enum StatType: String, CaseIterable, Codable {
    case strength = "Сила"
    case wisdom = "Мудрость"
    case charisma = "Харизма"
    case wealth = "Богатство"
    case spirit = "Дух"
}

enum QuestKind: String, Codable {
    case steps
    case mindful
    case social
}

struct Quest: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    let details: String
    let kind: QuestKind
    let target: Int
    let rewardStat: StatType
    let rewardPoints: Int
    var isSecret: Bool
    var isCompleted: Bool

    init(id: UUID = UUID(), title: String, details: String, kind: QuestKind, target: Int, rewardStat: StatType, rewardPoints: Int, isSecret: Bool = false, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.details = details
        self.kind = kind
        self.target = target
        self.rewardStat = rewardStat
        self.rewardPoints = rewardPoints
        self.isSecret = isSecret
        self.isCompleted = isCompleted
    }
}


