//
//  AppFeature.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 5/1/24.
//
import ComposableArchitecture

@Reducer
struct AppFeature {
  @ObservableState
  struct State {
    var login: LoginFeature.State?
    var mainTab: MainTabFeature.State?
    
    mutating func setFor(isLogged: Bool) {
      login = isLogged ? nil : .init()
      mainTab = !isLogged ? nil : .init()
    }
  }
  
  enum Action {
    case login(LoginFeature.Action)
    case mainTab(MainTabFeature.Action)
    case onAppear
    case userLogged(Bool)
  }
  @Dependency(\.appleAuthorizationClient) var appleAuthorizationClient
  @Dependency(\.keychainClient) var keychainClient

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .login(.delegate(.loggedIn)):
        state.setFor(isLogged: true)
        return .none
        
      case .login:
        return .none

      case .mainTab(.settings(.logout(.success))):
        state.mainTab = nil
        state.login = .init()
        return .none
        
      case .mainTab:
        return .none
        
      case .onAppear:
        return .run { send in
          let currentUserIdentifier = try? keychainClient.get(.userIdentifier)
          let isLogged = await appleAuthorizationClient.isLogged(userIdentifier: currentUserIdentifier ?? "")
          await send(.userLogged(isLogged))
        }
        
      case .userLogged(let isLogged):
        state.setFor(isLogged: isLogged)
        return .none
      }
    }
    .ifLet(\.login, action: \.login) {
      LoginFeature()
    }
    .ifLet(\.mainTab, action: \.mainTab) {
      MainTabFeature()
    }
  }
}
