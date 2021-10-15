//
//  Missions.swift
//  terrela
//
//  Created by Eric Morales on 10/15/21.
//

// NEED FIXING!!! ------------------------------------------------------------------------
// There is a problem with the wikiURL for one of the first 20 missions it says that the
// url is invalid even though you can put it in the browser and the browser open a page.
// ---------------------------------------------------------------------------------------

import Foundation

struct Missions {
    let count: Int
    let nextPage: URL?
    let missions: [Mission]
}

struct Mission {
    let id: Int
    let missionURL: URL
    let name: String
    let description: String?
    let agencies: [Agencie]
    let imageURL: URL
    let startDate: String?
    let endDate: String?
    let infoURL: URL?
    //let wikiURL: URL?
    
    func formatDate(stringDate: String) -> String {
        let dateFormatterStringToDate = ISO8601DateFormatter()
        let date = dateFormatterStringToDate.date(from: stringDate)

        let dateFormatterDateToString = DateFormatter()
        dateFormatterDateToString.dateFormat = "MMMM dd, yyyy"

        return dateFormatterDateToString.string(from: date!)
    }
}

struct Agencie {
    let id: Int
    let url: URL
    let name: String
    let type: String?
}

extension Missions: Decodable {
    enum MissionsKeys: String, CodingKey {
        case count
        case nextPage = "next"
        case missions = "results"
    }
    
    init(from decoder: Decoder) throws {
        let missionsContainer = try decoder.container(keyedBy: MissionsKeys.self)
        
        count = try missionsContainer.decode(Int.self, forKey: .count)
        nextPage = try missionsContainer.decodeIfPresent(URL.self, forKey: .nextPage)
        missions = try missionsContainer.decode([Mission].self, forKey: .missions)
    }
}

extension Mission: Decodable {
    enum MissionKeys: String, CodingKey {
        case id
        case missionURL = "url"
        case name
        case description
        case agencies
        case imageURL = "image_url"
        case startDate = "start_date"
        case endDate = "end_date"
        case infoURL = "info_url"
        //case wikiURL = "wiki_url"
    }
    
    init(from decoder: Decoder) throws {
        let missionsContainer = try decoder.container(keyedBy: MissionKeys.self)
        
        id = try missionsContainer.decode(Int.self, forKey: .id)
        missionURL = try missionsContainer.decode(URL.self, forKey: .missionURL)
        name = try missionsContainer.decode(String.self, forKey: .name)
        description = try missionsContainer.decodeIfPresent(String.self, forKey: .description)
        agencies = try missionsContainer.decode([Agencie].self, forKey: .agencies)
        imageURL = try missionsContainer.decode(URL.self, forKey: .imageURL)
        startDate = try missionsContainer.decodeIfPresent(String.self, forKey: .startDate)
        endDate = try missionsContainer.decodeIfPresent(String.self, forKey: .endDate)
        infoURL = try missionsContainer.decodeIfPresent(URL.self, forKey: .infoURL)
        //wikiURL = try missionsContainer.decodeIfPresent(URL.self, forKey: .wikiURL)
    }
}

extension Agencie: Decodable {
    enum AgencieKeys: String, CodingKey {
        case id
        case url
        case name
        case type
    }
    
    init(from decoder: Decoder) throws {
        let agencieContainer = try decoder.container(keyedBy: AgencieKeys.self)
        
        id = try agencieContainer.decode(Int.self, forKey: .id)
        url = try agencieContainer.decode(URL.self, forKey: .url)
        name = try agencieContainer.decode(String.self, forKey: .name)
        type = try agencieContainer.decodeIfPresent(String.self, forKey: .type)
    }
}
