import ComposableArchitecture
import SwiftUI

/**
 Feature itu ibarat viewModel, yang mana vm disini dipisahkan ada variabel dan action apa aja di setiap halamannya aja jelas dan dapat di unit test 100%
 */

/// parent feature of reducer (state and action)
struct AppFeature: Reducer {
  /// State sebagai variable
  struct State: Equatable {
    /// case path StackState di daftarkan untuk mendaftarkan feature state nya atau biasa di sebut vm yang di init di dalam parent (kumpulan vm). di insert untuk halaman di bawahnya / child view (setelah push atau present)
    var path = StackState<Path.State>()
    var standupsList = StandupsListFeature.State()
  }
  /// Action sebagai action dari user, contoh klik button
  enum Action: Equatable {
    /// case path ini di buat untuk mengetahui di screen tersebut pindah ke halaman mana aja yang di daftarkan StackAction
    case path(StackAction<Path.State, Path.Action>)
    case standupsList(StandupsListFeature.Action)
  }
  
  /// Dependency disini digunakan agar bisa di unit test karna list disini menggunakan uuid dan ada date yang selalu berubah ubah jika get dari device
  @Dependency(\.date.now) var now
  @Dependency(\.uuid) var uuid
  
  struct Path: Reducer {
    /// kumpulan feature yang mana ada state dan action yang wajib di daftarkan 1 : 1 (1 banding 1)
    /// contoh detail dengan detail, dll
    /// lalu akan masuk / tubs ke NavigationStackStore, yang mana NavigationStackStore ini berfungsi untuk pindah ke halaman tujuan menggunakan metode TCA agar tidak berat
    enum State: Equatable {
      case detail(StandupDetailFeature.State)
      case meeting(Meeting, standup: Standup) /// kalau di cek ini model, coba cek ini untuk apa
      case recordMeeting(RecordMeetingFeature.State)
    }
    enum Action: Equatable {
      case detail(StandupDetailFeature.Action)
      case meeting(Never)
      case recordMeeting(RecordMeetingFeature.Action)
    }
    var body: some ReducerOf<Self> {
      /// jika ReducerOf / turunan reducernya tidak di daftarkan maka halaman tersebut tidak bisa di apa apa karna action dan variablenya nggak ada (vm nya tidak dikirim karna init state nya di awal)
      /// pendaftaran ini di lakukan manual
      Scope(state: /State.detail, action: /Action.detail) {
        StandupDetailFeature()
      }
      Scope(state: /State.recordMeeting, action: /Action.recordMeeting) {
        RecordMeetingFeature()
      }
    }
  }
  
  /// unit test hitung waktu dan save ke file manager
  @Dependency(\.continuousClock) var clock
  @Dependency(\.dataManager.save) var saveData
  
  /// ini merupakan halaman utama, list daily
  /// karna setiap feature wajib mempunya body ReducerOf untuk di daftarkan ada action apa aja
  var body: some ReducerOf<Self> {
    Scope(state: \.standupsList, action: /Action.standupsList) {
      StandupsListFeature()
    }
    
    /// sedangkan fungsi ini adalah sebagai delegate. yang mana kiriman data dari child ke parent agar parent dapat melakukan tugasnya
    /// contoh kirim data dari halaman P ke halaman A (jauh kan, nah ini cara loncatnya pakai delegate)
    Reduce { state, action in
      switch action {
        /// ini case dari halaman detail
      case let .path(.element(id: _, action: .detail(.delegate(action)))):
        switch action {
        case let .deleteStandup(id: id):
          /// sedangkan ini untuk menghapus atau update list jika di hapus dari halaman detail
          state.standupsList.standups.remove(id: id)
          return .none
          
        case let .standupUpdated(standup):
          /// contohnya adalah ini, menghapus jumlah person dari halaman detail agar di list (first view) berubah sesuai dengan data terakhir di edit pada halaman detail
          state.standupsList.standups[id: standup.id] = standup
          return .none
        }
        
        /// ini case dari halaman record meeting
      case let .path(.element(id: id, action: .recordMeeting(.delegate(action)))):
        switch action {
        case let .saveMeeting(transcript: transcript):
          /// karna di init di awal jadi bisa pakai dropLast().last tanpa perlu pusing index ke berapa
          /// sebenernya kode di bawah ini bisa di taruh di halaman tujuan, tapi si owner pengen kasih tau gimana caranya kalau misalnya di jalanin di parent view
          guard let detailID = state.path.ids.dropLast().last
          else {
            XCTFail("Record meeting is the last element in the stack. A detail feature should proceed it.")
            return .none
          }
          state.path[id: detailID, case: /Path.State.detail]?.standup.meetings.insert(
            Meeting(
              id: self.uuid(),
              date: self.now,
              transcript: transcript
            ),
            at: 0
          )
          guard let standup = state.path[id: detailID, case: /Path.State.detail]?.standup
          else { return .none }
          state.standupsList.standups[id: standup.id] = standup
          return .none
        }
        
      case .path:
        /// ini lupa untuk apa, mungkin next bisa di coba coba
        return .none
        
      case .standupsList:
        /// ini lupa untuk apa, mungkin next bisa di coba coba
        return .none
      }
    }
    .forEach(\.path, action: /Action.path) {
      /// wajib menggunakan foreach, kalau nggak ada forEach maka turunannya semuanya nggak bisa jalan karna nggak ada vm
      Path()
    }
    
    /// Reduce di bawah ini dibuat jika ada perubahan maka 1 detik setelah nyaakan melakukan saving. jadi bukan via minimize atau kill aplikasi
    /// bisa di pakai untuk case lain seperti sinkronisasi dengan server tanpa menggunakan save button
    Reduce { state, _ in
        .run { [standups = state.standupsList.standups] _ in
          enum CancelID { case saveDebounce }
          try await withTaskCancellation(id: CancelID.saveDebounce, cancelInFlight: true) {
            try await self.clock.sleep(for: .seconds(1))
            try self.saveData(
              JSONEncoder().encode(standups),
              .standups
            )
          }
        }
    }
  }
}

struct AppView: View {
  let store: StoreOf<AppFeature>
  
  var body: some View {
    NavigationStackStore(
      self.store.scope(state: \.path, action: { .path($0) })
    ) {
      StandupsListView(
        store: self.store.scope(
          state: \.standupsList,
          action: { .standupsList($0) }
        )
      )
    } destination: { state in
      /// ini dibuat untuk pindah ke halaman tujuan
      switch state {
      case .detail:
//        ExampleView()
        CaseLet(
          /AppFeature.Path.State.detail,
           action: AppFeature.Path.Action.detail,
           then: StandupDetailView.init(store:)
        )
      case let .meeting(meeting, standup: standup):
        MeetingView(meeting: meeting, standup: standup) /// ini pindah halaman biasa yang mana halaman tersebut tidak terdapat reducer
      case .recordMeeting:
        /// sedangkan ini cara pindah ke halaman tujuan yang mana halaman tujuan nya terdapat reducer
        CaseLet(
          /AppFeature.Path.State.recordMeeting,
           action: AppFeature.Path.Action.recordMeeting,
           then: RecordMeetingView.init(store:)
        )
      }
    }
  }
}

extension URL {
  /// simpan data menggunakan documentsDirectory langsung standups.json
  static let standups = Self.documentsDirectory.appending(component: "standups.json")
}

#Preview {
  AppView(
    store: Store(
      initialState: AppFeature.State(
        standupsList: StandupsListFeature.State()
      )
    ) {
      AppFeature()
        ._printChanges()
    } withDependencies: {
      $0.dataManager = .mock(initialData: try? JSONEncoder().encode([Standup.mock]))
    }
  )
}

#Preview("Quick finish meeting") {
  var standup = Standup.mock
  standup.duration = .seconds(6)
  
  return AppView(
    store: Store(
      initialState: AppFeature.State(
        path: StackState([
          .detail(StandupDetailFeature.State(standup: standup)),
          .recordMeeting(RecordMeetingFeature.State(standup: standup))
        ]),
        standupsList: StandupsListFeature.State(
          //          standups: [standup]
        )
      )
    ) {
      AppFeature()
        ._printChanges()
    }
  )
}
