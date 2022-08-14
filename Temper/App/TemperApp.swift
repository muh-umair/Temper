//
//  TemperApp.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import SwiftUI

@main
struct TemperApp: App {
    var body: some Scene {
        WindowGroup {
            MainCoordinatorView(coordinator: .init())
        }
    }
}
