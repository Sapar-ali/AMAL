import SwiftUI

enum OnboardingStep: Int, CaseIterable {
    case welcome
    case email
    case otp
    case realms
    case profile
    case healthkit
    case calendar
    case notifications
    case done
}

struct OnboardingFlowView: View {
    @State private var step: OnboardingStep = .welcome

    var body: some View {
        VStack {
            switch step {
            case .welcome:
                WelcomeView { step = .email }
            case .email:
                EmailView(onNext: { step = .otp }, onBack: { step = .welcome })
            case .otp:
                OTPView(onNext: { step = .realms }, onBack: { step = .email })
            case .realms:
                RealmsView(onNext: { step = .profile }, onBack: { step = .otp })
            case .profile:
                ProfileView(onNext: { step = .healthkit }, onBack: { step = .realms })
            case .healthkit:
                PermissionView(title: "HealthKit", message: "Позволь видеть шаг, сон и меру — советы станут точнее. Лишь чтение.", onNext: {
                    HealthKitManager.shared.requestAuthorization { _ in
                        step = .calendar
                    }
                }, onBack: { step = .profile })
            case .calendar:
                PermissionView(title: "Календарь", message: "Покажи окна дня — вплету квест в твой ритм.", onNext: {
                    CalendarManager.shared.requestAccess { _ in
                        step = .notifications
                    }
                }, onBack: { step = .healthkit })
            case .notifications:
                PermissionView(title: "Уведомления", message: "Когда будить героя? Когда подводить итоги?", onNext: {
                    NotificationManager.shared.requestAuthorization { granted in
                        if granted {
                            NotificationManager.shared.scheduleDaily(hour: 8, minute: 0, id: "morning", title: "AMAL", body: "Рассвет зовёт. Новый квест ждёт.")
                            NotificationManager.shared.scheduleDaily(hour: 21, minute: 0, id: "evening", title: "AMAL", body: "Сложи доспех на ночь. Итоги ждут.")
                        }
                        step = .done
                    }
                }, onBack: { step = .calendar })
            case .done:
                MainTabView()
            }
        }
        .padding()
    }
}

private struct WelcomeView: View {
    var onNext: () -> Void
    var body: some View {
        VStack(spacing: 24) {
            Text("Путник, каждое утро — новый квест.")
                .font(.title)
                .multilineTextAlignment(.center)
            Button("Начать", action: onNext)
                .buttonStyle(.borderedProminent)
        }
    }
}

private struct EmailView: View {
    @State private var email: String = ""
    var onNext: () -> Void
    var onBack: () -> Void
    var body: some View {
        VStack(spacing: 16) {
            Text("Оставь знак связи — перо пришлёт ключ.")
            TextField("email", text: $email)
                .textInputAutocapitalization(.never)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
            HStack {
                Button("Назад", action: onBack)
                Spacer()
                Button("Отправить код", action: onNext)
                    .buttonStyle(.borderedProminent)
                    .disabled(email.isEmpty)
            }
        }
    }
}

private struct OTPView: View {
    @State private var code: String = ""
    var onNext: () -> Void
    var onBack: () -> Void
    var body: some View {
        VStack(spacing: 16) {
            Text("Введи ключ из письма.")
            TextField("Код", text: $code)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
            HStack {
                Button("Назад", action: onBack)
                Spacer()
                Button("Далее", action: onNext)
                    .buttonStyle(.borderedProminent)
                    .disabled(code.count < 4)
            }
        }
    }
}

private struct RealmsView: View {
    @State private var selected: Set<String> = []
    var onNext: () -> Void
    var onBack: () -> Void
    let options = ["Здоровье","Учёба","Отношения","Финансы","Дух"]
    var body: some View {
        VStack(spacing: 16) {
            Text("Выбери две земли для начала")
            ForEach(options, id: \.self) { opt in
                Toggle(opt, isOn: Binding(
                    get: { selected.contains(opt) },
                    set: { isOn in
                        if isOn { selected.insert(opt) } else { selected.remove(opt) }
                    }
                ))
            }
            HStack {
                Button("Назад", action: onBack)
                Spacer()
                Button("Далее", action: onNext)
                    .buttonStyle(.borderedProminent)
                    .disabled(!(selected.count == 2))
            }
        }
    }
}

private struct ProfileView: View {
    @State private var age: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""
    var onNext: () -> Void
    var onBack: () -> Void
    var body: some View {
        VStack(spacing: 12) {
            Text("Чтобы доспех лёг верно, назови меру тела.")
            TextField("Возраст (16–80)", text: $age).keyboardType(.numberPad).textFieldStyle(.roundedBorder)
            TextField("Рост (см)", text: $height).keyboardType(.numberPad).textFieldStyle(.roundedBorder)
            TextField("Вес (кг)", text: $weight).keyboardType(.numberPad).textFieldStyle(.roundedBorder)
            HStack {
                Button("Назад", action: onBack)
                Spacer()
                Button("Далее", action: onNext)
                    .buttonStyle(.borderedProminent)
                    .disabled(!isValid)
            }
        }
    }
    private var isValid: Bool {
        guard let a = Int(age), let h = Int(height), let w = Int(weight) else { return false }
        return (16...80).contains(a) && (130...210).contains(h) && (40...180).contains(w)
    }
}

private struct PermissionView: View {
    let title: String
    let message: String
    var onNext: () -> Void
    var onBack: () -> Void
    var body: some View {
        VStack(spacing: 16) {
            Text(title).font(.title2)
            Text(message).multilineTextAlignment(.center)
            HStack {
                Button("Назад", action: onBack)
                Spacer()
                Button("Продолжить", action: onNext)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}

 


