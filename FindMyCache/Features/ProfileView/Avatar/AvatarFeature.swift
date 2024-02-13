//
//  AvatarFeature.swift
//  FindMyCache
//
//  Created by Iván Ruiz Monjo on 13/2/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct AvatarFeature {
    @ObservableState
    struct State {
        var avatarData: Data?
        var imagePickerType: ImagePickerType?
        @Presents var confirmationDialog: ConfirmationDialogState<Action.ConfirmationDialog>?
    }

    enum Action {
        case avatarTapped
        case confirmationDialog(PresentationAction<ConfirmationDialog>)
        case setImagePickerType(ImagePickerType?)
        case setAvatarData(Data?)

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
                return .none

            case .confirmationDialog(.presented(.camera)):
                state.imagePickerType = .camera
                return .none

            case .confirmationDialog:
                return .none

            case .setImagePickerType(let type):
                state.imagePickerType = type
                return .none

            case .setAvatarData(let data):
                state.avatarData = data
                state.imagePickerType = nil
                return .none
            }
        }
        .ifLet(\.$confirmationDialog, action: \.confirmationDialog)
    }
}
