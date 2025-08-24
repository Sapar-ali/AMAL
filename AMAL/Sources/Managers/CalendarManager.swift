import Foundation
import EventKit

final class CalendarManager {
    static let shared = CalendarManager()
    private let store = EKEventStore()

    private init() {}

    func requestAccess(completion: @escaping (Bool) -> Void) {
        store.requestAccess(to: .event) { granted, _ in
            DispatchQueue.main.async { completion(granted) }
        }
    }
}


