//
//  ProfileFeature.swift
//  FindMyCache
//
//  Created by Iván Ruiz Monjo on 13/2/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ProfileFeature {
    @ObservableState
    struct State {
        var avatar = AvatarFeature.State()
        var name = ""
        var email = ""
    }

    enum Action: BindableAction {
        case avatar(AvatarFeature.Action)
        case binding(BindingAction<State>)
    }

    var body: some ReducerOf<Self> {
        BindingReducer()
        Scope(state: \.avatar, action: \.avatar) {
            AvatarFeature()
        }
        Reduce<State, Action> { state, action in
            switch action {
            case .avatar:
                return .none
            case .binding:
                return .none
            }
        }
    }
}
