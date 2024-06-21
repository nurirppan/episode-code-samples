import ComposableArchitecture
import SwiftUI
/**
 nurirppan : catatan
 */

@Reducer
struct CounterFeature {
  @ObservableState
  struct State {
    var count = 0
    var isObservingCount = true
  }
  enum Action {
    case decrementButtonTapped
    case incrementButtonTapped
    case toggleIsObservingCount
  }
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .decrementButtonTapped:
        state.count -= 1
        return .none
      case .incrementButtonTapped:
        state.count += 1
        return .none
      case .toggleIsObservingCount:
        state.isObservingCount.toggle()
        return .none
      }
    }
  }
}

struct ContentView: View {
  let store: StoreOf<CounterFeature>

  var body: some View {
    // WithViewStore(self.store, observe: ) { viewStore in
    //WithPerceptionTracking { /// WithPerceptionTracking di pakai untuk ios di bawah 17, karna jika tidak di pakai akan muncul warning biru dan ios di bawah 17 tidak akan berjalan vm atau fungsinya
      let _ = Self._printChanges()
      Form {
        if self.store.isObservingCount {
          Text(self.store.count.description)
        }
        Button("Decrement") { self.store.send(.decrementButtonTapped) }
        Button("Increment") { self.store.send(.incrementButtonTapped) }
        Button("Toggle count") { self.store.send(.toggleIsObservingCount) }
      }
    //}
  }
}

#Preview {
  ContentView(
    store: Store(initialState: CounterFeature.State()) {
      CounterFeature()
    }
  )
}
