//
//  LoginViewViewModel.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

/// ViewModel for `LoginView`
final class LoginViewViewModel: ObservableObject, Identifiable {
    /// identifiable ID to distinguish the ViewModel
    let id: String = UUID().uuidString
}
