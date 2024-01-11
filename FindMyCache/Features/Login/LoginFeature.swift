//
//  LoginFeature.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 5/1/24.
//

import AuthenticationServices
import ComposableArchitecture
import Foundation


@Reducer
struct LoginFeature {
  struct State {}
  
  enum Action {
    case loginResult(Result<Void, Error>)
    case signInResult(Result<User, Error>)
    case signedInWithApple(ASAuthorizationAppleIDCredential)
  }
  
  @Dependency(\.keychainClient) var keychainClient
  @Dependency(\.apiClient) var apiClient
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .loginResult(.failure(let error)):
        print(error)
  
        return .none
      case .loginResult:
        return .none
  
      case .signedInWithApple(let authorizationCredential):
        return .run { send in
          let params = CreateUserRequestParams(
            email: "ivanruizmonjo@gmail.com",
            username: "ivangodfather",
            avatarData: nil,
            authorizationCredential: authorizationCredential
          )
          print("authorizationCode \(authorizationCredential.authorizationCode.utf8 ?? "")")
          let result = await Result { try await self.apiClient.createUser(params) }
          await send(.signInResult(result))
        }
      case .signInResult(let result):
        print(result)
        return .none
      }
    }
  }
}
