import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }

            MovementsView()
                .tabItem { Label("Movimenti", systemImage: "list.bullet.rectangle") }

            PaymentsView()
                .tabItem { Label("Pagamenti", systemImage: "arrow.left.arrow.right.circle.fill") }

            CardsView()
                .tabItem { Label("Carte", systemImage: "creditcard.fill") }

            ProfileView()
                .tabItem { Label("Profilo", systemImage: "person.crop.circle.fill") }
        }
        .tint(Theme.Colors.primary)
    }
}

#Preview {
    MainTabView().environmentObject(AppState())
}
