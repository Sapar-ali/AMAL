import Foundation

@MainActor
final class QuestManager: ObservableObject {
    static let shared = QuestManager()
    @Published private(set) var today: [Quest] = []

    private init() {}

    func generateForToday(hasCalendarTime: Bool, stepsDefault: Int = 6000) {
        var quests: [Quest] = []

        // Основной квест: шаги
        quests.append(Quest(
            title: "Квест: \(stepsDefault) шагов",
            details: "Держи темп. Каждый шаг — зерно завтрашней силы.",
            kind: .steps,
            target: stepsDefault,
            rewardStat: .strength,
            rewardPoints: 10,
            isSecret: false
        ))

        // Секретная миссия: mindfulness или социальная
        let secret: Quest
        if hasCalendarTime {
            secret = Quest(
                title: "Секрет: 5 минут тишины",
                details: "Пять минут тишины — урок громче шума.",
                kind: .mindful,
                target: 5,
                rewardStat: .spirit,
                rewardPoints: 20,
                isSecret: true
            )
        } else {
            secret = Quest(
                title: "Секрет: позвони близкому",
                details: "Корни питают крону. Позвони и слушай сердцем.",
                kind: .social,
                target: 1,
                rewardStat: .wisdom,
                rewardPoints: 20,
                isSecret: true
            )
        }
        quests.append(secret)

        today = quests
    }

    func complete(_ quest: Quest) {
        guard let idx = today.firstIndex(of: quest) else { return }
        today[idx].isCompleted = true
        StatsManager.shared.add(today[idx].rewardPoints, to: today[idx].rewardStat)
    }
}


