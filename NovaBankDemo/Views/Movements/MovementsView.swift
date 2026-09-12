import SwiftUI

struct MovementsView: View {
    @EnvironmentObject var appState: AppState
    @State private var searchText = ""
    @State private var selectedFilter: FilterOption = .all

    enum FilterOption: String, CaseIterable {
        case all = "Tutti"
        case income = "Entrate"
        case expense = "Uscite"
    }

    private var filteredTransactions: [Transaction] {
        appState.transactions.filter { transaction in
            let matchesFilter: Bool
            switch selectedFilter {
            case .all: matchesFilter = true
            case .income: matchesFilter = transaction.isIncome
            case .expense: matchesFilter = !transaction.isIncome
            }
            let matchesSearch = searchText.isEmpty ||
                transaction.title.localizedCaseInsensitiveContains(searchText) ||
                transaction.subtitle.localizedCaseInsensitiveContains(searchText)
            return matchesFilter && matchesSearch
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack(spacing: Theme.Spacing.s) {
                    ForEach(FilterOption.allCases, id: \.self) { option in
                        FilterChip(title: option.rawValue, isSelected: selectedFilter == option) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedFilter = option
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, Theme.Spacing.l)
                .padding(.vertical, Theme.Spacing.m)

                if filteredTransactions.isEmpty {
                    EmptyStateView(
                        icon: "list.bullet.rectangle",
                        title: "Nessun movimento",
                        message: "Non ci sono movimenti che corrispondono ai filtri selezionati."
                    )
                    Spacer()
                } else {
                    List {
                        ForEach(filteredTransactions) { transaction in
                            NavigationLink(value: transaction) {
                                TransactionRow(transaction: transaction)
                            }
                            .listRowBackground(Theme.Colors.background)
                            .listRowSeparatorTint(Theme.Colors.divider)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .background(Theme.Colors.background.ignoresSafeArea())
            .navigationTitle("Movimenti")
            .searchable(text: $searchText, prompt: "Cerca movimento")
            .navigationDestination(for: Transaction.self) { transaction in
                MovementDetailView(transaction: transaction)
            }
        }
    }
}

private struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Theme.Fonts.body)
                .padding(.horizontal, Theme.Spacing.m)
                .padding(.vertical, Theme.Spacing.s)
                .background(isSelected ? Theme.Colors.primary : Theme.Colors.surface)
                .foregroundColor(isSelected ? .white : Theme.Colors.textPrimary)
                .cornerRadius(20)
        }
    }
}

struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String

    var body: some View {
        VStack(spacing: Theme.Spacing.m) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(Theme.Colors.textSecondary.opacity(0.5))
            Text(title)
                .font(Theme.Fonts.headline)
                .foregroundColor(Theme.Colors.textPrimary)
            Text(message)
                .font(Theme.Fonts.body)
                .foregroundColor(Theme.Colors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Theme.Spacing.xl)
        }
        .padding(.top, Theme.Spacing.xxl)
    }
}

#Preview {
    MovementsView().environmentObject(AppState())
}
