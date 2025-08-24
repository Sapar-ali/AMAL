import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Дом", systemImage: "house.fill") }
            StatsView()
                .tabItem { Label("Статы", systemImage: "chart.bar.fill") }
            ProfileScreen()
                .tabItem { Label("Профиль", systemImage: "person.fill") }
        }
    }
}


