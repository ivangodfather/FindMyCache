//
//  SettingsView.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 6/1/24.
//

import ComposableArchitecture
import SwiftUI

struct SettingsView: View {
  var store: StoreOf<SettingsFeature>
  
  var body: some View {
    NavigationStack {
      Form {
        UserSectionView()
        Section {
          NavigationLink {
            FrequentQuestionsView()
          } label: {
            Label("Frequent Questions", systemImage: "questionmark.circle")
          }
          Link(destination: URL(string: "https://www.apple.com")!) {
            Label("Contact us", systemImage: "envelope.circle")
          }
          Link(destination: URL(string: "https://www.apple.com")!) {
            Label("Terms of use", systemImage: "newspaper.circle")
          }
          Link(destination: URL(string: "https://www.apple.com")!) {
            Label("Privacy Policy", systemImage: "lock.circle")
          }
          LabeledContent {
            Text(Bundle.main.appVersionLong)
          } label: {
            Label("Version", systemImage: "info.circle")
          }

        } header: {
          Text("About")
        }
        Section {
          ColorSchemeModeView()
          Toggle(isOn: .constant(false), label: {
            Label("Haptic Feedback", systemImage: "iphone.radiowaves.left.and.right.circle")
          })

        } header: {
          Text("App")
        }
        Section {
          Button(role: .destructive) {
            store.send(.logoutButtonTapped)
          } label: {
            Label("Sign out", systemImage: "arrow.uturn.left.circle")
          }
        } footer: {
          Text("Ver: \(Bundle.main.appVersionLong) (\(Bundle.main.appBuild)) ")
        }
      }
      .navigationTitle("Settings")
    }
    .tint(.primary)
  }
}

#Preview {
  SettingsView(store: .init(initialState: SettingsFeature.State()) {
    SettingsFeature()
  })
}
