//
//  RootView.swift
//  Prototype House Watch App
//
//  Created by Felipe Espinoza on 06/10/2023.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false

    func login() async {}
}

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel = .init()
    @EnvironmentObject var rootViewModel: RootViewModel

    var body: some View {
        ScrollView {
            VStack {
                TextField("Email or Member ID", text: $viewModel.username)
                    .textContentType(.username)
                    .multilineTextAlignment(.center)

                SecureField("Password", text: $viewModel.password)
                    .textContentType(.password)
                    .multilineTextAlignment(.center)

                Button(action: login, label: {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Sign in")
                    }
                })
                .buttonStyle(.borderedProminent)
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Image(.logoSmall)
            }
        }
    }

    func login() {
        Task {
            viewModel.isLoading = true
            try? await Task.sleep(for: .seconds(2))
            await viewModel.login()
            viewModel.isLoading = false
            withAnimation {
                rootViewModel.isLoggedIn = true
            }
        }
    }
}

class RootViewModel: ObservableObject {
//    @Published var state: State = .idle
    @Published var isLoggedIn: Bool

    init(isLoggedIn: Bool = false) {
        self.isLoggedIn = isLoggedIn
    }

    enum State {
        case idle
        case notLoggedIn
        case loggedIn
    }
}

class UpcomingWorkoutListViewModel: ObservableObject {
    @Published var state: State = .idle
    @Published var upcomingWorkoutGroups: [GroupPerDayViewData] = []

    struct GroupPerDayViewData: Identifiable {
        let id: UUID = .init()
        let name: String
        let workouts: [UpcomingWorkoutViewData]
    }

    struct UpcomingWorkoutViewData: Identifiable {
        let id: UUID = .init()
        let name: String
        let instructor: String?
        let club: String
        let time: String
        let duration: String
    }

    func initialLoad() async {
        guard case .idle = state else {
            return
        }

        state = .loading
        try? await Task.sleep(for: .seconds(2))
        upcomingWorkoutGroups = [
            .init(
                name: "Tomorrow",
                workouts: [
                    .init(
                        name: "BODYPUMP™",
                        instructor: "w/Tony Stark",
                        club: "Nydalen",
                        time: "06:30",
                        duration: "60 min"
                    ),
                    .init(
                        name: "Indoor Running",
                        instructor: "w/Steve Rogers",
                        club: "Nydalen",
                        time: "10:00",
                        duration: "60 min"
                    ),
                ]
            ),
            .init(
                name: "Monday, 9th of October",
                workouts: [
                    .init(
                        name: "Love2Dance",
                        instructor: "w/Thor Odinson",
                        club: "Nydalen",
                        time: "10:00",
                        duration: "60 min"
                    ),
                ]
            ),
        ]
        state = .dataLoaded
    }

    enum State {
        case idle
        case loading
        case dataLoaded
        case error(_ error: Error)
    }
}

struct UpcomingWorkoutListView: View {
    @StateObject var viewModel: UpcomingWorkoutListViewModel = .init()

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView()
            case .dataLoaded:
                content
            case .error:
                VStack {
                    Image(systemName: "xmark.circle")
                        .tint(Color.red)

                    Text("Error :(")
                }
            }
        }
        .task {
            await viewModel.initialLoad()
        }
    }

    var content: some View {
        List {
            ForEach(viewModel.upcomingWorkoutGroups) { group in
                Section {
                    ForEach(group.workouts) { upcomingWorkout in
                        HStack {
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundStyle(Color.red)
                                .frame(width: 4)
                            VStack(alignment: .leading) {
                                Text(upcomingWorkout.name).bold()
                                Group {
                                    Text(upcomingWorkout.club)
                                    Text(upcomingWorkout.time)
                                }
                                .font(.footnote)
                            }
                        }
                    }
                } header: {
                    Text(group.name)
                }
            }
        }
    }
}

struct LoginLandingView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    Image(.satsLogo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)

                    Text("To start, please sign in with your MemberID or Email")
                        .multilineTextAlignment(.center)

                    NavigationLink(destination: { LoginView() }) {
                        Text("Sign in")
                    }
                }
//                .background(Color.red)
            }
        }
        .background(Color.blue.opacity(0.1))
    }
}

import Combine

class QrViewModel: ObservableObject {
    @Published var state: State
    var timer: Timer?

    var observations: Set<AnyCancellable> = []

    init(state: State = .idle, timer: Timer? = nil) {
        self.state = state
        self.timer = timer

        setupObservations()
    }

    func setupObservations() {
        $state
            .removeDuplicates()
            .sink { newValue in
                print("==== changed to \(newValue.name)")
            }
            .store(in: &observations)
    }

    func fetchQrCode() async {
        print("====== \(#function)")
//        state = .loading
//        do {
//            try await Task.sleep(for: .seconds(2))
        state = .dataLoaded(image: Image(.qrSample))
//        } catch {
//            state = .error(error)
//        }
    }

    enum State: Equatable {
        static func == (lhs: QrViewModel.State, rhs: QrViewModel.State) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle),
                 (.loading, .loading),
                 (.dataLoaded, .dataLoaded),
                 (.error, .error):
                return true
            default:
                return false
            }
        }

        case idle
        case loading
        case dataLoaded(image: Image)
        case error(_ error: Error)

        var name: String {
            switch self {
            case .idle: "Idle"
            case .loading: "Loading"
            case .dataLoaded: "Data Loaded"
            case .error: "Error"
            }
        }
    }
}

@available(watchOS 10.0, *)
struct QrView: View {
    @StateObject var viewModel: QrViewModel = .init()

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView()
            case let .dataLoaded(image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(4)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            case .error:
                VStack {
                    Image(systemName: "xmark.circle")
                        .tint(Color.red)

                    Text("Error :(")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .containerBackground(Color.blue.opacity(0.1).gradient, for: .tabView)
//        .background(Color.blue.opacity(0.1))
        .task {
            await viewModel.fetchQrCode()
        }
    }
}

@available(watchOS 10.0, *)
struct HomeView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @State var selectedTab: Int = 1

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                QrView()
                    .navigationTitle("Check in")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar(content: {
                        ToolbarItem(placement: .primaryAction) {
                            Button("Settings") {}
                        }
                    })
            }
            .tag(1)

            NavigationStack {
                UpcomingWorkoutListView()
                    .navigationTitle("Upcoming Workouts")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tag(2)

//            NavigationStack {
//                ScrollView {
//                    VStack {
//                        Button("Logout", role: .destructive) {
//                            withAnimation {
//                                rootViewModel.isLoggedIn = false
//                            }
//                            print("log out!")
//                        }
//                    }
//                }
//                .background(Color.blue.opacity(0.1))
//                .containerShape(Rectangle())
//                .navigationTitle("Settings")
//                .navigationBarTitleDisplayMode(.inline)
//            }
//            .tag(3)
        }
        .tabViewStyle(.verticalPage)
//        .tabViewStyle(.page)
    }
}

@available(watchOS 10.0, *)
struct RootView: View {
    @StateObject var rootViewModel: RootViewModel = .init()

    var body: some View {
        Group {
            if rootViewModel.isLoggedIn {
                HomeView()
            } else {
                LoginLandingView()
            }
        }
        .transition(.opacity)
        .environmentObject(rootViewModel)
    }
}

@available(watchOS 10.0, *)
#Preview {
//    NavigationStack {
//        UpcomingWorkoutListView()
//            .navigationTitle("Upcoming Workouts")
//            .navigationBarTitleDisplayMode(.inline)
//    }
    RootView(rootViewModel: .init(isLoggedIn: true))
//    HomeView(selectedTab: 2)
//        .environmentObject(RootViewModel(isLoggedIn: true))
}
