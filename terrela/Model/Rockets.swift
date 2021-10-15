//
//  Rockets.swift
//  terrela
//
//  Created by Eric Morales on 10/15/21.
//

import Foundation

struct Rockets {
    let nextPage: URL?
    let rockets: [Rocket]
}

struct Rocket {
    let id: Int
    let rocketURL: URL
    let name: String
    let serialNumber: String?
    let description: String
    let rocketConfig: RocketConfig
}

struct RocketConfig {
    let isBeingUsed: Bool
    let imageURL: URL
}

extension Rockets: Decodable {
    enum RocketsKeys: String, CodingKey {
        case nextPage = "next"
        case rockets = "results"
    }
    
    init(from decoder: Decoder) throws {
        let rocketsContainer = try decoder.container(keyedBy: RocketsKeys.self)

        nextPage = try rocketsContainer.decode(URL.self, forKey: .nextPage)
        rockets = try rocketsContainer.decode([Rocket].self, forKey: .rockets)
    }
}

extension Rocket: Decodable {
    enum RocketKeys: String, CodingKey {
        case id
        case rocketURL = "url"
        case name
        case serialNumber = "serial_number"
        case description
        case rocketConfig = "spacecraft_config"
    }
    
    init(from decoder: Decoder) throws {
        let rocketContainer = try decoder.container(keyedBy: RocketKeys.self)
        
        id = try rocketContainer.decode(Int.self, forKey: .id)
        rocketURL = try rocketContainer.decode(URL.self, forKey: .rocketURL)
        name = try rocketContainer.decode(String.self, forKey: .name)
        serialNumber = try rocketContainer.decode(String.self, forKey: .serialNumber)
        description = try rocketContainer.decode(String.self, forKey: .description)
        rocketConfig = try rocketContainer.decode(RocketConfig.self, forKey: .rocketConfig)
    }
}

extension RocketConfig: Decodable {
    enum RocketConfigKeys: String, CodingKey {
        case isBeingUsed = "in_use"
        case imageURL = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let rocketConfigContainer = try decoder.container(keyedBy: RocketConfigKeys.self)
        
        isBeingUsed = try rocketConfigContainer.decode(Bool.self, forKey: .isBeingUsed)
        imageURL = try rocketConfigContainer.decode(URL.self, forKey: .imageURL)
    }
}
