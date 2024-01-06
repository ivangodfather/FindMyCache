//
//  LoginView.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 4/1/24.
//

import AuthenticationServices
import ComposableArchitecture
import SwiftUI

private enum Layout {
  static let loginButtonHeight = CGFloat(48)
}

struct LoginView: View {
  var store: StoreOf<LoginFeature>
  
  var body: some View {
    VStack {
      Text("Find My Cache")
        .font(.title)
      Image(systemName: "magnifyingglass")
        .resizable()
        .frame(width: 100, height: 100)
      Text("El juego para disfrutar al aire libre")
        .font(.title2)
      Spacer()
      loginButtons
    }
    .padding()
  }
  
  var loginButtons: some View {
    VStack {
      SignInWithAppleButton(.signIn) { request in
        request.requestedScopes = [.email, .fullName]
      }  onCompletion: { result in
        switch result {
        case .success(let authorization):
          switch authorization.credential {
          case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            store.send(.signedInWithApple(userIdentifier))
          default:
            break
          }
        case .failure(let error):
          print("SignInWithAppleButton", error)
        }
      }
      .frame(height: Layout.loginButtonHeight)
      .signInWithAppleButtonStyle(.whiteOutline)
    }
  }
}

#Preview {
  LoginView(
    store: .init(
      initialState: LoginFeature.State()) {
        LoginFeature()
      }
  )
}
#Preview {
  LoginView(
    store: .init(
      initialState: LoginFeature.State()) {
        LoginFeature()
      }
  )
  .environment(\.colorScheme, .dark)
}
