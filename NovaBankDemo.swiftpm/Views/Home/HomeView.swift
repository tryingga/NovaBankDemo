import SwiftUI

/// Home replicata dallo screenshot: canvas di design 706x1536 scalato proporzionalmente.
struct HomeView: View {
    @EnvironmentObject var appState: AppState
    var selectedTab: Binding<NovaTab>? = nil

    private var movements: [HomeMovement] {
        Array(appState.transactions.prefix(HomeDesign.movementRowCount))
            .enumerated()
            .map { index, transaction in
                HomeMovement(transaction: transaction, status: index == 0 ? "NON CONTABILIZZATO" : nil)
            }
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let scale = geo.size.width / HomeDesign.width
                ScrollView(.vertical, showsIndicators: false) {
                    HomeCanvas(movements: movements, onShowAll: {
                        selectedTab?.wrappedValue = .investimenti
                    }, onShowCards: {
                        selectedTab?.wrappedValue = .carte
                    })
                    .frame(width: HomeDesign.width, height: HomeDesign.totalHeight)
                    .scaleEffect(scale, anchor: .topLeading)
                    .frame(
                        width: HomeDesign.width * scale,
                        height: HomeDesign.totalHeight * scale,
                        alignment: .topLeading
                    )
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            }
            .ignoresSafeArea()
            .background(Color.white)
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: Transaction.self) { transaction in
                MovementDetailView(transaction: transaction)
            }
        }
    }
}

/// Composizione del canvas: ero verde + sezione movimenti + carte.
struct HomeCanvas: View {
    @EnvironmentObject var appState: AppState
    let movements: [HomeMovement]
    var onShowAll: (() -> Void)? = nil
    var onShowCards: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 0) {
            HeroSection(onShowCards: onShowCards)
                .frame(width: HomeDesign.width, height: HomeDesign.heroHeight)
            MovementsSectionView(movements: movements, onShowAll: onShowAll)
                .frame(
                    width: HomeDesign.width,
                    height: HomeDesign.movHeaderHeight + HomeDesign.rowHeight * CGFloat(movements.count)
                )
            CardsSectionView(cards: appState.cards, onShowCards: onShowCards)
                .frame(
                    width: HomeDesign.width,
                    height: HomeDesign.cardsSectionHeight
                )
            FeaturedSectionsView()
                .frame(
                    width: HomeDesign.width,
                    height: HomeDesign.featuredSectionHeight
                )
            Color.clear.frame(height: HomeDesign.bottomEndPadding)
        }
        .background(Color.white)
    }
}

#Preview {
    HomeView(selectedTab: .constant(.home))
        .environmentObject(AppState())
}