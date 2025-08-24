import Foundation
import HealthKit

@MainActor
final class HealthKitManager {
    static let shared = HealthKitManager()
    private let healthStore = HKHealthStore()

    private init() {}

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false)
            return
        }

        let readTypes: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount),
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning),
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
            HKObjectType.categoryType(forIdentifier: .mindfulSession),
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis),
            HKObjectType.quantityType(forIdentifier: .bodyMass),
            HKObjectType.quantityType(forIdentifier: .height)
        ].compactMap { $0 }.reduce(into: Set<HKObjectType>()) { $0.insert($1) }

        healthStore.requestAuthorization(toShare: nil, read: readTypes) { success, _ in
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }

    func fetchTodayStepCount(completion: @escaping (Double) -> Void) {
        guard let stepsType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            completion(0)
            return
        }

        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date(), options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: stepsType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            let total = result?.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0
            DispatchQueue.main.async {
                completion(total)
            }
        }
        healthStore.execute(query)
    }
}


