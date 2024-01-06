//
//  AppleAuthorizationClient.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 5/1/24.
//

import AuthenticationServices
import ComposableArchitecture

@DependencyClient
struct AppleAuthorizationClient {
  // Not empty identifiers are assumed to be logged in for testing purposes
  var isLogged: @Sendable (_ userIdentifier: String) async -> Bool = { !$0.isEmpty }
}

extension AppleAuthorizationClient: DependencyKey {
  static var liveValue: AppleAuthorizationClient = Self { userIdentifier in
    await withCheckedContinuation { continuation in
      ASAuthorizationAppleIDProvider().getCredentialState(forUserID: userIdentifier) { state, _ in
        continuation.resume(returning: state == .authorized)
      }
    }
  }
}

extension DependencyValues {
  var appleAuthorizationClient: AppleAuthorizationClient {
    get { self[AppleAuthorizationClient.self] }
    set { self[AppleAuthorizationClient.self] = newValue }
  }
}
