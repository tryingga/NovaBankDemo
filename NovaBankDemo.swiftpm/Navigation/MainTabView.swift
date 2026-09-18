import SwiftUI

enum NovaTab: Hashable {
    case home, investimenti, operazioni, carte, altro
}

/// Tab container con bottom navigation flottante personalizzata.
struct MainTabView: View {
    @State private var selection: NovaTab = .home

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            TabView(selection: $selection) {
                HomeView(selectedTab: $selection)
                    .tag(NovaTab.home)
                    .tabItem { Label("Home", systemImage: "house.fill") }

                InvestmentsView()
                    .tag(NovaTab.investimenti)
                    .tabItem { Label("Investimenti", systemImage: "chart.bar") }

                PaymentsView()
                    .tag(NovaTab.operazioni)
                    .tabItem { Label("Operazioni", systemImage: "eurosign.circle") }

                CardsView()
                    .tag(NovaTab.carte)
                    .tabItem { Label("Carte", systemImage: "creditcard") }

                ProfileView()
                    .tag(NovaTab.altro)
                    .tabItem { Label("Altro", systemImage: "list.bullet") }
            }
            .toolbar(.hidden, for: .tabBar)

            BottomOverlay(contentWidth: HomeDesign.width, contentHeight: HomeDesign.height) {
                ZStack(alignment: .topLeading) {
                    FloatingChatButton()
                        .place(470, 1265, 208, 105)
                    FloatingBottomNavBar(selection: $selection)
                        .place(27, 1396, 652, 105)
                }
            }
        }
    }
}

#Preview {
    MainTabView().environmentObject(AppState())
}