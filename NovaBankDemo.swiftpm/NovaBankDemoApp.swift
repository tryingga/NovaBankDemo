import SwiftUI

@main
struct NovaBankDemoApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .preferredColorScheme(.light)
                .statusBarHidden(true)
        }
    }
}
