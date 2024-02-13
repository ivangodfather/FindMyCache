//
//  AvatarView.swift
//  FindMyCache
//
//  Created by Iván Ruiz Monjo on 13/2/24.
//

import ComposableArchitecture
import Foundation
import SwiftUI

@Reducer
struct AvatarFeature {
    @ObservableState
    struct State {
        var avatarData: Data?
        var imagePickerType: UIImagePickerController.SourceType = .photoLibrary
        @Presents var confirmationDialog: ConfirmationDialogState<Action.ConfirmationDialog>?
        var isSheetPresented = false
    }

    enum Action {
        case avatarTapped
        case confirmationDialog(PresentationAction<ConfirmationDialog>)
        case setAvatarData(Data?)
        case setSheetPresented(Bool)

        enum ConfirmationDialog {
            case camera
            case photoLibrary
        }
    }

    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .avatarTapped:
                state.confirmationDialog = .init(title: {
                    TextState("Choose your avatar from:")
                }, actions: {
                    ButtonState(action: .camera) {
                        TextState("Camera")
                    }
                    ButtonState(action: .photoLibrary) {
                        TextState("Image gallery")
                    }
                    ButtonState(role: .cancel) {
                        TextState("Cancel")
                    }
                }, message: {
                    TextState("This is how others see you.")
                })
                return .none

            case .confirmationDialog(.presented(.photoLibrary)):
                state.imagePickerType = .photoLibrary
                state.isSheetPresented = true
                return .none

            case .confirmationDialog:
                return .none

            case .setSheetPresented(let isPresented):
                state.isSheetPresented = isPresented
                return .none

            case .setAvatarData(let data):
                state.avatarData = data
                return .none
            }
        }
        .ifLet(\.$confirmationDialog, action: \.confirmationDialog)
    }
}

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
                    sourceType: store.imagePickerType
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
