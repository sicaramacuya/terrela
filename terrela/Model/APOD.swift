//
//  APOD.swift
//  terrela
//
//  Created by Eric Morales on 10/11/21.
//

import Foundation

struct APOD {
    let date: String
    let title: String
    let explanation: String
    let mediaType: String
    let url: URL
    
    func formatDate(stringDate: String) -> String {
        let dateFormatterStringToDate = DateFormatter()
        dateFormatterStringToDate.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatterStringToDate.date(from: stringDate)

        let dateFormatterDateToString = DateFormatter()
        dateFormatterDateToString.dateFormat = "MMMM dd, yyyy"

        return dateFormatterDateToString.string(from: date!)
    }
}

extension APOD: Decodable {
    enum APODKeys: String, CodingKey {
        case date
        case title
        case explanation
        case mediaType = "media_type"
        case url
    }
    
    
    // try JSONDecoder().decode([APOD].self, from: data)
    
    init(from decoder: Decoder) throws {
        // Decode the APOD from the API call
        let apodContainer = try decoder.container(keyedBy: APODKeys.self)
        
        // Decode each of the properties from the API into the appropiate type (string, etc.) for their associated struct variable
        date = try apodContainer.decode(String.self, forKey: .date)
        title = try apodContainer.decode(String.self, forKey: .title)
        explanation = try apodContainer.decode(String.self, forKey: .explanation)
        mediaType = try apodContainer.decode(String.self, forKey: .mediaType)
        url = try apodContainer.decode(URL.self, forKey: .url)
    }
}
