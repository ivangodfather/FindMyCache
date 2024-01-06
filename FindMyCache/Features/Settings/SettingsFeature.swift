//
//  SettingsFeature.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 6/1/24.
//

import ComposableArchitecture

@Reducer
struct SettingsFeature {
  @ObservableState
  struct State {
  }
  
  enum Action {
    case logoutButtonTapped
    case logout(Result<Void, Error>)
  }
  
  @Dependency(\.keychainClient) var keychainClient
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .logoutButtonTapped:
        let result = Result { try keychainClient.delete(.userIdentifier) }
        return .send(.logout(result))

      case .logout(.failure(let error)):
        print(error)
        return .none

      case .logout(.success):
        return .none
      }
    }
  }
}
