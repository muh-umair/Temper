//
//  ShiftRowViewViewModel.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation
import Services
import CoreLocation

/// ViewModel for `ShiftRowView`
final class ShiftRowViewViewModel: ObservableObject, Identifiable {
    // MARK: - Properties
    let id: String
    let imageURL: URL?
    let category: String
    let distance: String
    let clientName: String
    let time: String
    let earnings: String
    let startsAt: Date
    
    // MARK: - Computed properties
    var categoryAndDistance: String {
        "\(category.uppercased()) - \(distance)"
    }
            
    // MARK: - Initializer
    init(shift: Shift, locationProvider: LocationProviderProtocol?) {
        id = shift.id
        imageURL = shift.job.imageURL
        category = shift.job.category
        
        clientName = shift.job.clientName
        let startsAt = shift.startsAt.formatted(date: .omitted, time: .shortened)
        let endsAt = shift.endsAt.formatted(date: .omitted, time: .shortened)
        if !startsAt.isEmpty && !endsAt.isEmpty {
            time = "\(startsAt) - \(endsAt)"
        } else {
            time = ""
        }
        // Earnings with currency symbol e.g. $10.0
        earnings = "\(Shift.Currency(shorthand: shift.earningsPerHourCurrencyValue).sign) \(shift.earningsPerHourAmountValue)"
        self.startsAt = shift.startsAt
        
        // Distance from user's current location
        let fromLocation = CLLocation(
            latitude: locationProvider?.currentLocation.latitude ?? 0.0,
            longitude: locationProvider?.currentLocation.longitude ?? 0.0
        )
        let toLocation = CLLocation(
            latitude: shift.job.address.coordinate.latitude,
            longitude: shift.job.address.coordinate.longitude
        )
        let distanceInMeters = toLocation.distance(from: fromLocation)
        if distanceInMeters < 1000 {
            distance = "\(distanceInMeters) m"
        } else {
            distance = "\(Int(distanceInMeters/1000)) km"
        }
    }
}
