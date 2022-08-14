//
//  Shift+Job.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

// MARK: - Job related to Shift.
public extension Shift {
    struct Job: Decodable {
        public let id: String
        public let title: String
        public let imageURL: URL?
        public let clientName: String
        public let address: Address
        public let category: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case title
            case project
            case category
            case address = "report_at_address"
        }
        
        enum ProjectKeys: String, CodingKey {
            case client
        }
        
        enum ClientKeys: String, CodingKey {
            case name
            case links
        }
        
        enum LinksKeys: String, CodingKey {
            case heroImage = "hero_image"
        }
        
        enum CategoryKeys: String, CodingKey {
            case nameTranslation = "name_translation"
        }
        
        enum NameTranslationKeys: String, CodingKey {
            case english = "en_GB"
        }
        
        public init(id: String, title: String, imageURL: URL?, clientName: String, address: Address, category: String) {
            self.id = id
            self.title = title
            self.imageURL = imageURL
            self.clientName = clientName
            self.address = address
            self.category = category
        }
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            let projectValues = try values.nestedContainer(keyedBy: ProjectKeys.self, forKey: .project)
            let clientValues = try projectValues.nestedContainer(keyedBy: ClientKeys.self, forKey: .client)
            let linksValues = try? clientValues.nestedContainer(keyedBy: LinksKeys.self, forKey: .links)
            
            let categoryValues = try values.nestedContainer(keyedBy: CategoryKeys.self, forKey: .category)
            let nameTranslationValues = try categoryValues.nestedContainer(keyedBy: NameTranslationKeys.self, forKey: .nameTranslation)
            
            self.init(
                id: try values.decode(String.self, forKey: .id),
                title: try values.decode(String.self, forKey: .title),
                imageURL: try linksValues?.decode(URL.self, forKey: .heroImage),
                clientName: try clientValues.decode(String.self, forKey: .name),
                address: try values.decode(Address.self, forKey: .address),
                category: try nameTranslationValues.decode(String.self, forKey: .english)
            )
        }
    }
}
