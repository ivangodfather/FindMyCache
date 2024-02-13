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
        enum Delegate {
            case loggedIn
        }

        case delegate(Delegate)
        case signInResponse(Result<CreateUserResponse, Error>)
        case signedInWithApple(ASAuthorizationAppleIDCredential)
    }

    @Dependency(\.keychainClient) var keychainClient
    @Dependency(\.apiClient) var apiClient

    var body: some ReducerOf<Self> {
        Reduce<State, Action> { _, action in
            switch action {
            case .delegate:
                return .none

            case .signInResponse(.success(let response)):
                do {
                    try keychainClient.set(response.accessToken, .accessToken)
                    try keychainClient.set(response.refreshToken, .refreshToken)
                } catch {
                    print(error)
                    return .none
                }
                return .send(.delegate(.loggedIn))

            case .signInResponse(.failure(let error)):
                print(error)
                return .none

            case .signedInWithApple(let authorizationCredential):
                return .run { send in
                    let params = CreateUserRequestParams(
                        email: authorizationCredential.email ?? "ivanruizmonjo@gmail.com", // TODO: Should be optional or show another flow for forcing the email with authcre.fullName
                        username: authorizationCredential.user,
                        avatarData: nil,
                        authorizationCredential: authorizationCredential
                    )
                    try? keychainClient.set(authorizationCredential.user, .userIdentifier)
                    let result = await Result { try await self.apiClient.createUser(params) }
                    await send(.signInResponse(result))
                }
            }
        }
    }
}
