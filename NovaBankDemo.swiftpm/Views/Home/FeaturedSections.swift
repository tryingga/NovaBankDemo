import SwiftUI

/// Sezione "Sezioni in evidenza" in fondo alla Home: titolo, griglia a due
/// colonne (Reward / Assicurazioni), divider e testo con link "Personalizza app".
struct FeaturedSectionsView: View {
    var body: some View {
        VStack(spacing: 0) {
            FeaturedHeader()
                .frame(width: HomeDesign.width, height: 150)

            HStack(spacing: 20) {
                FeatureCard(
                    icon: "trophy.fill",
                    title: "Reward iniziative e vantaggi"
                )
                FeatureCard(
                    icon: "umbrella.fill",
                    title: "Assicurazioni e previdenza"
                )
            }
            .padding(.horizontal, 27)
            .frame(width: HomeDesign.width, height: 250, alignment: .topLeading)

            Color.clear.frame(height: 36)

            FeaturedFooter()
                .frame(width: HomeDesign.width, height: 170)
        }
        .frame(width: HomeDesign.width, height: HomeDesign.featuredSectionHeight)
        .background(Color.white)
    }
}

/// Intestazione "Sezioni in evidenza" (stesso stile dei titoli di sezione).
private struct FeaturedHeader: View {
    var body: some View {
        VStack(spacing: 0) {
            Color.clear.frame(height: 44)

            Text("Sezioni in evidenza")
                .font(.system(size: 45, weight: .regular))
                .foregroundColor(.black)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 27)

            Spacer(minLength: 0)
        }
        .frame(width: HomeDesign.width, alignment: .topLeading)
    }
}

/// Box grigio chiaro con icona, titolo in grassetto e link "Vai alla sezione".
private struct FeatureCard: View {
    let icon: String
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(systemName: icon)
                .font(.system(size: 44, weight: .regular))
                .foregroundColor(Theme.Colors.brandGreen)

            Spacer(minLength: 0)

            Text(title)
                .font(.system(size: 27, weight: .light))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 0)

            Button(action: {}) {
                Text("Vai alla sezione")
                    .font(.system(size: 23, weight: .regular))
                    .underline()
                    .foregroundColor(Theme.Colors.brandGreen)
            }
            .buttonStyle(.plain)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(RoundedRectangle(cornerRadius: 16).fill(Theme.Colors.surfaceSoft))
    }
}

/// Divider + testo informativo con link "Personalizza app".
private struct FeaturedFooter: View {
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Theme.Colors.novaDivider)
                .frame(width: HomeDesign.width, height: 2)

            Color.clear.frame(height: 30)

            (
                Text("Se desideri personalizzare altre impostazioni, come l'accesso all'app, sfondo e azioni veloci ")
                    .font(.system(size: 23, weight: .regular))
                    .foregroundColor(Theme.Colors.novaGray)
                + Text("Personalizza app")
                    .font(.system(size: 23, weight: .regular))
                    .foregroundColor(Theme.Colors.brandGreen)
                    .underline()
            )
            .multilineTextAlignment(.leading)
            .lineSpacing(6)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.leading, 27)
            .padding(.trailing, 27)
            .frame(maxWidth: .infinity, alignment: .topLeading)

            Spacer(minLength: 0)
        }
        .frame(width: HomeDesign.width, height: 170, alignment: .topLeading)
    }
}

#Preview {
    FeaturedSectionsView()
}