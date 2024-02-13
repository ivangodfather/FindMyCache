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
            .aspectRatio(contentMode: .fill)
            .onTapGesture {
                store.send(.avatarTapped)
            }
            .confirmationDialog($store.scope(
                state: \.confirmationDialog,
                action: \.confirmationDialog
            ))
            .sheet(item: $store.imagePickerType.sending(\.setImagePickerType)) { type in
                ImagePicker(
                    imageData: $store.avatarData.sending(\.setAvatarData),
                    sourceType: type.sourceType
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
    .background(Color.red)
    .frame(width: 150)
}
