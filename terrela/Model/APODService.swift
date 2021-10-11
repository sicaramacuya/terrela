//
//  APODService.swift
//  terrela
//
//  Created by Eric Morales on 10/11/21.
//

import Foundation
import UIKit

class NasaApiRequest {
  let token = "ucrAeSPhtwIUIaubxTiMhg5OM7iqPTt7ZnhtT2aK"
  let baseURL = "https://api.nasa.gov/"
}

class APODRequest: NasaApiRequest, Request {
  typealias ResponseType = APOD

  func getParams() -> [String: String] {
    return [
        "count": "10"
    ]
  }

  func getPath() -> String {
    return "planetary/apod"
  }

  func getHTTPMethod() -> String {
    return "GET"
  }

  func getHeaders() -> [String : String] {
    return [
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer \(token)"
    ]
  }
}

class APODService {
  private let networking = Networking()

  func getPictureOfTheDay(
    completion: @escaping (Result<[APOD], Error>) -> Void
  ) {
    let request = APODRequest()
    networking.send(request) { result in
      switch result {
      case .success(let picture):
        completion(.success(picture))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
