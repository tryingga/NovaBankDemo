import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        Group {
            if appState.isLoggedIn {
                MainTabView()
                    .transition(.opacity.combined(with: .move(edge: .trailing)))
            } else {
                LoginView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: appState.isLoggedIn)
    }
}

#Preview {
    RootView().environmentObject(AppState())
}
