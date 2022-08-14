//
//  MockShift.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation
import Services
import CoreLocation

/// Mock data for `Shift` to be used for preview and testing
let mockShift = Shift(
    id: "wqvezww",
    startsAt: Date(timeIntervalSinceNow: 0),
    endsAt: Date(timeIntervalSinceNow: 3600),
    earningsPerHourCurrencyValue: "EUR",
    earningsPerHourAmountValue: 14.0,
    job: .init(
        id: "q6pw9z",
        title: "Enthousiaste Rider",
        imageURL: URL(string: "https://tmpr-photos.ams3.digitaloceanspaces.com/hero380/41774.jpg")!,
        clientName: "Flink - Delft Centrum",
        address: .init(
            coordinate: CLLocationCoordinate2D(latitude: 52.00836, longitude: 4.361479),
            fullAddress: "Breestraat 37 2611RE Delft",
            directionsURL: URL(string: "https://www.google.com/maps/dir/?api=1&destination=Breestraat+37%2CDelft+2611RE%2CThe+Netherlands")
        ),
        category: "Delivery"
    )
)
