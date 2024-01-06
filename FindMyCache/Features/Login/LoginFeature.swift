//
//  LoginFeature.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 5/1/24.
//

import ComposableArchitecture

@Reducer
struct LoginFeature {
  struct State {}
  
  enum Action {
    case loginResult(Result<Void, Error>)
    case signedInWithApple(_ userIdentifier: String)
  }
  
  @Dependency(\.keychainClient) var keychainClient
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .loginResult(.failure(let error)):
        print(error)
  
        return .none
      case .loginResult:
        return .none
  
      case .signedInWithApple(let userIdentifier):
        let result = Result { try keychainClient.set(userIdentifier, .userIdentifier) }
        return .send(.loginResult(result))
      }
    }
  }
}
