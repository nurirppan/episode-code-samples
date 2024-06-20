import ComposableArchitecture
import SwiftUI

struct StandupsListFeature: Reducer {
  struct State: Equatable {
    @PresentationState var addStandup: StandupFormFeature.State? /// contoh kode menggunakan present via tca agar lebih ringan kalau present berkali kali contoh 100x
    var standups: IdentifiedArrayOf<Standup> = [] /// pakai IdentifiedArrayOf karna lebih stabil

    init(
      addStandup: StandupFormFeature.State? = nil
    ) {
      self.addStandup = addStandup
      do {
        @Dependency(\.dataManager.load) var loadData /// penggunaan load data ini dari deeplink, jadi di generalkan. kalau save dan load data semuanya wajob via json decoder. karna ada fungsi setiap 1 detik melakukan save
        self.standups = try JSONDecoder().decode(IdentifiedArrayOf<Standup>.self, from: loadData(.standups))
      } catch {
        self.standups = []
      }
    }
  }
  enum Action: Equatable {
    case addButtonTapped
    case addStandup(PresentationAction<StandupFormFeature.Action>)
    case cancelStandupButtonTapped
    case saveStandupButtonTapped
  }
  @Dependency(\.uuid) var uuid
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .addButtonTapped:
        /// si owner membuat fungsi ini ketika pertama kali klik tambah data dari list daily
        /// kalau bisnis logic nya via button save tidak perlu seperti ini
        state.addStandup = StandupFormFeature.State(standup: Standup(id: self.uuid()))
        return .none

      case .addStandup:
        return .none

      case .cancelStandupButtonTapped:
        state.addStandup = nil
        return .none

      case .saveStandupButtonTapped:
        guard let standup = state.addStandup?.standup
        else { return .none }
        state.standups.append(standup)
        state.addStandup = nil
        return .none
      }
    }
    /// karna bisa dari deeplink, dan bisa menyebabkan crash juga jadi menggunakan iflet
    .ifLet(\.$addStandup, action: /Action.addStandup) {
      StandupFormFeature()
    }
  }
}

struct StandupsListView: View {
  let store: StoreOf<StandupsListFeature>

  var body: some View {
    /// WithViewStore agar ringan walaupun sudah di push sebanyak 100 x
    WithViewStore(self.store, observe: \.standups) { viewStore in
      List {
        ForEach(viewStore.state) { standup in
          NavigationLink(
            /// walaupun sudah di daftarkan di "NavigationStackStore", tetap harus di init agar root nya terpanggil
            state: AppFeature.Path.State.detail(StandupDetailFeature.State(standup: standup))
          ) {
            CardView(standup: standup)
          }
            .listRowBackground(standup.theme.mainColor)
        }
      }
      .navigationTitle("Daily Standups")
      .toolbar {
        ToolbarItem {
          Button("Add") {
            viewStore.send(.addButtonTapped)
          }
        }
      }
      /// contoh penggunaan present
      .sheet(
        store: self.store.scope(
          state: \.$addStandup,
          action: { .addStandup($0) }
        )
      ) { store in
        /// kenapa setiap screen wajib menggunakan NavigationStack, coba cari tau apakah penggunaannya emang seperti ini atau agar toolbarnya berdiri sendiri
        NavigationStack {
          StandupFormView(store: store)
            .navigationTitle("New standup")
            .toolbar {
              ToolbarItem {
                Button("Save") { viewStore.send(.saveStandupButtonTapped) }
              }
              ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { viewStore.send(.cancelStandupButtonTapped) }
              }
            }
        }
      }
    }
  }
}

struct CardView: View {
  let standup: Standup

  var body: some View {
    VStack(alignment: .leading) {
      Text(self.standup.title)
        .font(.headline)
      Spacer()
      HStack {
        Label("\(self.standup.attendees.count)", systemImage: "person.3")
        Spacer()
        Label(self.standup.duration.formatted(.units()), systemImage: "clock")
          .labelStyle(.trailingIcon)
      }
      .font(.caption)
    }
    .padding()
    .foregroundColor(self.standup.theme.accentColor)
  }
}

struct TrailingIconLabelStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.title
      configuration.icon
    }
  }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
  static var trailingIcon: Self { Self() }
}

#Preview {
  MainActor.assumeIsolated {
    NavigationStack {
      StandupsListView(
        store: Store(
          initialState: StandupsListFeature.State(
//            standups: [.mock]
          )
        ) {
          StandupsListFeature()
            ._printChanges()
        }
      )
    }
  }
}
