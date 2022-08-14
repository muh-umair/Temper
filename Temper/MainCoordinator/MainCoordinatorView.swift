//
//  MainCoordinatorView.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import SwiftUI

/// Apps main coordinator to manage navigation
struct MainCoordinatorView: View {
    // MARK: - Properites
    @StateObject var coordinator: MainCoordinator
    
    // MARK: - View
    var body: some View {
        NavigationView {
            ShiftListView(viewModel: coordinator.shiftsListViewModel)
                .navigation(item: $coordinator.filtersViewModel) {
                    FilterView(viewModel: $0)
                }
                .navigation(item: $coordinator.mapViewModel) {
                    MapView(viewModel: $0)
                }
                .sheet(item: $coordinator.loginViewModel) {
                    LoginView(viewModel: $0)
                }
                .sheet(item: $coordinator.signupViewModel) {
                    SignupView(viewModel: $0)
                }
                .navigationBarHidden(true)
        }
        .preferredColorScheme(.light)
    }
}

// MARK: - Preview
struct MainCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        MainCoordinatorView(
            coordinator: .init()
        )
    }
}

