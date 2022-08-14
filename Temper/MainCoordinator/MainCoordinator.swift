//
//  MainCoordinatorViewCoordinator.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation
import Services

/// MainCoordinator to control the app navigation
final class MainCoordinator: ObservableObject {
    // MARK: - Publised properties
    @Published var shiftsListViewModel: ShiftListViewViewModel!
    @Published var loginViewModel: LoginViewViewModel?
    @Published var signupViewModel: SignupViewViewModel?
    @Published var filtersViewModel: FilterViewViewModel?
    @Published var mapViewModel: MapViewViewModel?
    
    // MARK: - Initializer
    init() {
        //Root view for navigation
        shiftsListViewModel = .init(
            shiftsRepository: ShiftRepository(),
            coordinator: self,
            locationProvider: LocationProvider()
        )
    }
}

// MARK: - Helpers
// As soon ViewModel is created HomeCoordinatorView show the respective view in navigation.
extension MainCoordinator {
    /// Open login scene
    func openLogin() {
        loginViewModel = .init()
    }
    
    /// Open sign scene
    func openSignup() {
        signupViewModel = .init()
    }
    
    /// Open filters scene
    func openFilters() {
        filtersViewModel = .init()
    }
    
    /// Open map scene
    func openMap() {
        mapViewModel = .init()
    }
}
