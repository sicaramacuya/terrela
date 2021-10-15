//
//  Networking.swift
//  terrela
//
//  Created by Eric Morales on 10/11/21.
//

import Foundation

protocol Request {
  associatedtype ResponseType
  
  var baseURL: String { get }

  /// Get the parameters from the endpoint and convert them into a string.
  func getParams() -> [String: String]

  /// Get the path of the endpoint.
  func getPath() -> String

  /// Get the HTTP Method.
  func getHTTPMethod() -> String

  /// Get the headers.
  func getHeaders() -> [String: String]

  /// This function allow the request that confroms to this protocol to have a custom handle of the data.
  ///
  /// Discussion:  If the request that conform to this protocol has a ResponseType that conform to Codable there is a default case to decode JSON data. In any other case the request will need to provide a custom handle method.
  func handle(_ data: Data) throws -> ResponseType
}

extension Request where ResponseType: Decodable {
  func handle(_ data: Data) throws -> ResponseType {
    try JSONDecoder().decode(ResponseType.self, from: data)
  }
}

enum NetworkingError: Error {
  case couldNotParse
  case noData
}

class Networking {
  private let urlSession = URLSession.shared

  func send<R: Request>(
    _ request: R,
    completion: @escaping (Result<R.ResponseType, Error>) -> Void
  ) {

    let paramsDictionary = request.getParams()

    let path = request.getPath()

    //create the full url from the above variables
    let fullURL = URL(string: request.baseURL.appending("\(path)?\(params(from: paramsDictionary))"))!

    // build the request
    var urlRequest = URLRequest(url: fullURL)
    urlRequest.httpMethod = request.getHTTPMethod()
    urlRequest.allHTTPHeaderFields = request.getHeaders()

    let task = urlSession.dataTask(with: urlRequest) { data, response, error in
      // Check for erros
      if let error = error {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
        return
      }

      // Check to see if there is any data that was retrieved.
      guard let data = data else {
        DispatchQueue.main.async {
          completion(.failure(NetworkingError.noData))
        }
        return
      }

      do {
        let result = try request.handle(data)
        DispatchQueue.main.async {
          completion(.success(result))
        }
      } catch {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      }
    }

    task.resume()
  }

  /// This functions accept a dictionary and return the keys and values reformatted as a string.
  private func params(from dictionary: [String: String]) -> String {
    let parameterArray = dictionary.map { key, value in
      return "\(key)=\(value)"
    }

    return parameterArray.joined(separator: "&")
  }
}
