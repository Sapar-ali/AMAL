import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        List {
            Section("Профиль") {
                Text("Возраст: —")
                Text("Рост: — см")
                Text("Вес: — кг")
            }
            Section("Разрешения") {
                Text("HealthKit: пока не запрошено")
                Text("Календарь: пока не запрошено")
            }
        }
    }
}


