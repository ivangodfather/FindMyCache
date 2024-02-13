//
//  ProfileView.swift
//  FindMyCache
//
//  Created by Iván Ruiz Monjo on 13/2/24.
//

import ComposableArchitecture
import SwiftUI

struct ProfileView: View {
    @Bindable var store: StoreOf<ProfileFeature>

    var body: some View {
        Form {
            VStack {
                Spacer()
                AvatarView(store: store.scope(state: \.avatar, action: \.avatar))
                    .frame(width: 150, height: 150, alignment: .center)
                Spacer()
            }
            .listRowBackground(Color.clear)
            .frame(maxWidth: .infinity)

            Section {
                TextField("Your name here", text: $store.name)
            } footer: {
                Text("This will be visible to other users. Should not contain invalid characters.")
                    .font(.caption)
            }
            Section {
                TextField("Your email here", text: $store.email)
            } footer: {
                Text("Should be a valid email.")
                    .font(.caption)
            }

            Button {

            } label: {
              Text("Update")
                .bold()
                .frame(maxWidth: .infinity)
            }
            .listRowBackground(Color.accentColor)
            .foregroundStyle(.white)
        }
        .navigationTitle("Your profile")
    }
}

#Preview {
    NavigationStack {
        ProfileView(store: .init(initialState: ProfileFeature.State()) {
            ProfileFeature()
        })
    }
}

