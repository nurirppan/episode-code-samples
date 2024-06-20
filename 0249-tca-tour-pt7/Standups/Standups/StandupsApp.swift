import ComposableArchitecture
import SwiftUI
/*
 nurirppan : https://github.com/pointfreeco/swift-composable-architecture
 State: 
 A type that describes the data your feature needs to perform its logic and render its UI.
 
 Action:
 A type that represents all of the actions that can happen in your feature, such as user actions, notifications, event sources and more.
 
 Reducer:
 A function that describes how to evolve the current state of the app to the next state given an action. The reducer is also responsible for returning any effects that should be run, such as API requests, which can be done by returning an Effect value.
 
 Store:
 The runtime that actually drives your feature. You send all user actions to the store so that the store can run the reducer and effects, and you can observe state changes in the store so that you can update UI.
 */

@main
struct StandupsApp: App {
  var body: some Scene {
    WindowGroup {
      var standup = Standup.mock
      let _ = standup.duration = .seconds(6)

        /// ini flow normal, masuk ke halaman beranda biasa karna "StackState" nya kosong
        /// StackState ini di pakai untuk deeplink dari halaman apapun ke halaman tujuan (fixing dari : bug dari swiftui yang gk bisa pindah ke halaman tujuan jika halaman tersebut tidak terbuka)
      AppView(
        store: Store(
          initialState: AppFeature.State(
            path: StackState([
//              .detail(StandupDetailFeature.State(standup: .mock)),
//              .recordMeeting(RecordMeetingFeature.State(standup: standup)),
//              .recordMeeting(RecordMeetingFeature.State(standup: standup)),
            ]),
            standupsList: StandupsListFeature.State(
//              standups: [standup]
            )
          )
        ) {
          AppFeature()
            ._printChanges() /// ini untuk menampilkan perubahan pada log. contohnya di bawah
        }
      )
    }
  }
}

//contoh log tambah daily
//received action:
//  AppFeature.Action.standupsList(.addButtonTapped)
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//-     _addStandup: nil,
//+     _addStandup: StandupFormFeature.State(
//+       _focus: .title,
//+       _standup: Standup(
//+         id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//+         attendees: [
//+           [0]: Attendee(
//+             id: UUID(7FD4C0E5-55D3-4460-9174-A333AD585539),
//+             name: ""
//+           )
//+         ],
//+         duration: 5 minutes,
//+         meetings: [],
//+         theme: .bubblegum,
//+         title: ""
//+       )
//+     ),
//      standups: […]
//    )
//  )
//
//-[RTIInputSystemClient remoteTextInputSessionWithID:performInputOperation:]  perform input operation requires a valid sessionID
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .title,
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: […],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .bubblegum,
//-         title: ""
//+         title: "N"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .title,
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: […],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .bubblegum,
//-         title: "N"
//+         title: "Nu"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .title,
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: […],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .bubblegum,
//-         title: "Nu"
//+         title: "Nur"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .title,
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: […],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .bubblegum,
//-         title: "Nur"
//+         title: "Nuri"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .title,
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: […],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .bubblegum,
//-         title: "Nuri"
//+         title: "Nurir"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .title,
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: […],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .bubblegum,
//-         title: "Nurir"
//+         title: "Nurirp"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .title,
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: […],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .bubblegum,
//-         title: "Nurirp"
//+         title: "Nurirpp"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .title,
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: […],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .bubblegum,
//-         title: "Nurirpp"
//+         title: "Nurirppa"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .title,
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: […],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .bubblegum,
//-         title: "Nurirppa"
//+         title: "Nurirppan"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .title,
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: […],
//          duration: 5 minutes,
//          meetings: [],
//-         theme: .bubblegum,
//+         theme: .navy,
//          title: "Nurirppan"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$focus, .attendee(UUID(7FD4C0E5-55D3-4460-9174-A333AD585539))))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//-       _focus: .title,
//+       _focus: .attendee(UUID(7FD4C0E5-55D3-4460-9174-A333AD585539)),
//        _standup: Standup(…)
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .attendee(UUID(7FD4C0E5-55D3-4460-9174-A333AD585539)),
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: [
//            [0]: Attendee(
//              id: UUID(7FD4C0E5-55D3-4460-9174-A333AD585539),
//-             name: ""
//+             name: "R"
//            )
//          ],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .navy,
//          title: "Nurirppan"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .attendee(UUID(7FD4C0E5-55D3-4460-9174-A333AD585539)),
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: [
//            [0]: Attendee(
//              id: UUID(7FD4C0E5-55D3-4460-9174-A333AD585539),
//-             name: "R"
//+             name: "Ri"
//            )
//          ],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .navy,
//          title: "Nurirppan"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .attendee(UUID(7FD4C0E5-55D3-4460-9174-A333AD585539)),
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: [
//            [0]: Attendee(
//              id: UUID(7FD4C0E5-55D3-4460-9174-A333AD585539),
//-             name: "Ri"
//+             name: "Rik"
//            )
//          ],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .navy,
//          title: "Nurirppan"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .attendee(UUID(7FD4C0E5-55D3-4460-9174-A333AD585539)),
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: [
//            [0]: Attendee(
//              id: UUID(7FD4C0E5-55D3-4460-9174-A333AD585539),
//-             name: "Rik"
//+             name: "Rika"
//            )
//          ],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .navy,
//          title: "Nurirppan"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(.addAttendeeButtonTapped)
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//-       _focus: .attendee(UUID(7FD4C0E5-55D3-4460-9174-A333AD585539))
//+       _focus: .attendee(UUID(B7A86FA0-AD75-40B4-83F3-FF56066FC0CF))
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: [
//            [0]: Attendee(…),
//+           [1]: Attendee(
//+             id: UUID(B7A86FA0-AD75-40B4-83F3-FF56066FC0CF),
//+             name: ""
//+           )
//          ],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .navy,
//          title: "Nurirppan"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .attendee(UUID(B7A86FA0-AD75-40B4-83F3-FF56066FC0CF)),
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: [
//            [0]: Attendee(…),
//            [1]: Attendee(
//              id: UUID(B7A86FA0-AD75-40B4-83F3-FF56066FC0CF),
//-             name: ""
//+             name: "A"
//            )
//          ],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .navy,
//          title: "Nurirppan"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .attendee(UUID(B7A86FA0-AD75-40B4-83F3-FF56066FC0CF)),
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: [
//            [0]: Attendee(…),
//            [1]: Attendee(
//              id: UUID(B7A86FA0-AD75-40B4-83F3-FF56066FC0CF),
//-             name: "A"
//+             name: "Ar"
//            )
//          ],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .navy,
//          title: "Nurirppan"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .attendee(UUID(B7A86FA0-AD75-40B4-83F3-FF56066FC0CF)),
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: [
//            [0]: Attendee(…),
//            [1]: Attendee(
//              id: UUID(B7A86FA0-AD75-40B4-83F3-FF56066FC0CF),
//-             name: "Ar"
//+             name: "Ara"
//            )
//          ],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .navy,
//          title: "Nurirppan"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  (No state changes)
//
//received action:
//  AppFeature.Action.standupsList(
//    .addStandup(
//      .presented(
//        .binding(.set(\State.$standup, Standup(…)))
//      )
//    )
//  )
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//      _addStandup: StandupFormFeature.State(
//        _focus: .attendee(UUID(B7A86FA0-AD75-40B4-83F3-FF56066FC0CF)),
//        _standup: Standup(
//          id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//          attendees: [
//            [0]: Attendee(…),
//            [1]: Attendee(
//              id: UUID(B7A86FA0-AD75-40B4-83F3-FF56066FC0CF),
//-             name: "Ara"
//+             name: "Aras"
//            )
//          ],
//          duration: 5 minutes,
//          meetings: [],
//          theme: .navy,
//          title: "Nurirppan"
//        )
//      ),
//      standups: […]
//    )
//  )
//
//received action:
//  AppFeature.Action.standupsList(.saveStandupButtonTapped)
//  AppFeature.State(
//    path: [:],
//    standupsList: StandupsListFeature.State(
//-     _addStandup: StandupFormFeature.State(
//-       _focus: .attendee(UUID(B7A86FA0-AD75-40B4-83F3-FF56066FC0CF)),
//-       _standup: Standup(
//-         id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//-         attendees: [
//-           [0]: Attendee(
//-             id: UUID(7FD4C0E5-55D3-4460-9174-A333AD585539),
//-             name: "Rika"
//-           ),
//-           [1]: Attendee(
//-             id: UUID(B7A86FA0-AD75-40B4-83F3-FF56066FC0CF),
//-             name: "Aras"
//-           )
//-         ],
//-         duration: 5 minutes,
//-         meetings: [],
//-         theme: .navy,
//-         title: "Nurirppan"
//-       )
//-     ),
//+     _addStandup: nil,
//      standups: [
//        [0]: Standup(…),
//+       [1]: Standup(
//+         id: UUID(B7F663EE-0CD6-4071-92CC-5ECA534E2320),
//+         attendees: [
//+           [0]: Attendee(
//+             id: UUID(7FD4C0E5-55D3-4460-9174-A333AD585539),
//+             name: "Rika"
//+           ),
//+           [1]: Attendee(
//+             id: UUID(B7A86FA0-AD75-40B4-83F3-FF56066FC0CF),
//+             name: "Aras"
//+           )
//+         ],
//+         duration: 5 minutes,
//+         meetings: [],
//+         theme: .navy,
//+         title: "Nurirppan"
//+       )
//      ]
//    )
//  )

