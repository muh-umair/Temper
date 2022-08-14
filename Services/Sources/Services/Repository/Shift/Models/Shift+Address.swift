//
//  Shift+Address.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation
import CoreLocation

// MARK: - Address related to Shift's Job.
public extension Shift {
    struct Address: Decodable {
        public let coordinate: CLLocationCoordinate2D
        public let fullAddress: String
        public let directionsURL: URL?
        
        enum CodingKeys: String, CodingKey {
            case coordinates = "geo"
            case line1
            case line2
            case links
        }
        
        enum CoordinateKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "lon"
        }
        
        enum LinksKeys: String, CodingKey {
            case directions = "get_directions"
        }
        
        init(coordinate: CLLocationCoordinate2D, fullAddress: String, directionsURL: URL?) {
            self.coordinate = coordinate
            self.fullAddress = fullAddress
            self.directionsURL = directionsURL
        }
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            let line1 = try values.decode(String.self, forKey: .line1)
            let line2 = try values.decode(String.self, forKey: .line2)
            
            let coordinateValues = try values.nestedContainer(keyedBy: CoordinateKeys.self, forKey: .coordinates)
            let latitude = try coordinateValues.decode(CLLocationDegrees.self, forKey: .latitude)
            let longitude = try coordinateValues.decode(CLLocationDegrees.self, forKey: .longitude)
            
            let linksValues = try values.nestedContainer(keyedBy: LinksKeys.self, forKey: .links)
            
            self.init(
                coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                fullAddress: "\(line1) \(line2)".trimmingCharacters(in: .whitespaces),
                directionsURL: try linksValues.decode(URL.self, forKey: .directions)
            )
        }
    }
}
