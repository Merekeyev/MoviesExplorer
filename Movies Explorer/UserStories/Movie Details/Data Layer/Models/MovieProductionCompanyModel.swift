//
//  MovieProductionCompanyModel.swift
//  Movies Explorer
//
//  Created by Temirlan on 11.06.2023.
//

import Foundation

struct MovieProductionCompanyModel: Decodable {
    let id: Int
    var logoURLPath: String?
    let name: String
    let originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoURLPath = "logoPath"
        case name
        case originCountry = "originCountry"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        logoURLPath = try container.decodeIfPresent(String.self, forKey: .logoURLPath)
        name = try container.decode(String.self, forKey: .name)
        originCountry = try container.decode(String.self, forKey: KeyedDecodingContainer<CodingKeys>.Key.originCountry)
    }
}
