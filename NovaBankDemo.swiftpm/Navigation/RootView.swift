import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    @State private var showSplash = true

    var body: some View {
        Group {
            if appState.isLoggedIn {
                MainTabView()
                    .transition(.opacity.combined(with: .move(edge: .trailing)))
            } else if showSplash {
                SplashView {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showSplash = false
                    }
                }
                .transition(.opacity)
            } else {
                IntesaLoginWelcomeView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: appState.isLoggedIn)
        .animation(.easeInOut(duration: 0.3), value: showSplash)
    }
}

#Preview {
    RootView().environmentObject(AppState())
}
