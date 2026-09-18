import SwiftUI
import UIKit

/// Pagina di pre-caricamento: sfondo bianco con logo centrale.
/// Dopo 4 secondi invia la chiusura tramite `onFinished`.
struct SplashView: View {
    var onFinished: (() -> Void)?

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            if let image = loadLogo() {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 60)
                    .padding(.horizontal, 48)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                onFinished?()
            }
        }
    }

    private func loadLogo() -> UIImage? {
        if let named = UIImage(named: "logoverdeISP") {
            return named
        }
        for subdirectory in [nil, "Resources", "Components"] {
            if let url = Bundle.main.url(
                forResource: "logoverdeISP",
                withExtension: "png",
                subdirectory: subdirectory
            ), let image = UIImage(contentsOfFile: url.path) {
                return image
            }
        }
        return nil
    }
}

#Preview {
    SplashView()
}