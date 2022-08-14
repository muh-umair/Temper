//
//  SignupViewViewModel.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

/// ViewModel for `SignupView`
final class SignupViewViewModel: ObservableObject, Identifiable {
    /// identifiable ID to distinguish the ViewModel
    let id: String = UUID().uuidString
}
