//
//  RocketService.swift
//  terrela
//
//  Created by Eric Morales on 10/15/21.
//

import Foundation
import UIKit

class LaunchLibraryApiRequest {
    let baseURL = "https://lldev.thespacedevs.com/2.2.0/"
}

class RocketsRequest: LaunchLibraryApiRequest, Request {
    typealias ResponseType = Rockets
    
    func getParams() -> [String : String] {
        return [
            "limit": "20"
        ]
    }
    
    func getPath() -> String {
        return "spacecraft"
    }
    
    func getHTTPMethod() -> String {
        "GET"
    }
    
    func getHeaders() -> [String : String] {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
}

class MissionsRequest: LaunchLibraryApiRequest, Request {
    typealias ResponseType = Missions
    
    func getParams() -> [String : String] {
        return [
            "limit": "20"
        ]
    }
    
    func getPath() -> String {
        return "program"
    }
    
    func getHTTPMethod() -> String {
        "GET"
    }
    
    func getHeaders() -> [String : String] {
        return [
          "Accept": "application/json",
          "Content-Type": "application/json",
        ]
    }
}

class LaunchLibraryService {
    private let networking = Networking()
    
    func getRockets(completion: @escaping (Result<[Rocket], Error>) -> Void) {
        let request = RocketsRequest()
        
        networking.send(request) { result in
            switch result {
            case .success(let rockets):
                completion(.success(rockets.rockets))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMissions(completion: @escaping (Result<[Mission], Error>) -> Void) {
        let request = MissionsRequest()
        
        networking.send(request) { result in
            switch result {
            case .success(let missions):
                completion(.success(missions.missions))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
