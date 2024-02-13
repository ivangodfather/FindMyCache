//
//  AvatarView.swift
//  FindMyCache
//
//  Created by Iván Ruiz Monjo on 13/2/24.
//

import ComposableArchitecture
import Foundation
import SwiftUI

struct AvatarView: View {
    @Bindable var store: StoreOf<AvatarFeature>

    var body: some View {
        image
            .scaledToFit()
            .onTapGesture {
                store.send(.avatarTapped)
            }
            .confirmationDialog($store.scope(
                state: \.confirmationDialog,
                action: \.confirmationDialog
            ))
            .sheet(isPresented: $store.isSheetPresented.sending(\.setSheetPresented)) {
                ImagePicker(
                    imageData: $store.avatarData.sending(\.setAvatarData),
                    sourceType: store.imagePickerType ?? .photoLibrary
                )
                .ignoresSafeArea(.all, edges: .bottom)
            }
    }

    @ViewBuilder
    var image: some View {
        if
            let data = store.avatarData,
            let uiImage = UIImage(data: data)
        {
            Image(uiImage: uiImage)
                .resizable()

        } else {
            Image(systemName: "person")
                .resizable()
        }
    }
}

#Preview {
    AvatarView(store: .init(initialState: .init()) {
        AvatarFeature()
    })
    .frame(width: 200)
}
