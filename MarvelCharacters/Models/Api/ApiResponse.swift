//
//  ApiResponse.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/26/21.
//

import Foundation

public struct ApiResponse: Decodable {
    let data: ApiData
    let code: Int
    let etag: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case code
        case etag
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try values.decode(ApiData.self, forKey: .data)
        self.code = try values.decode(Int.self, forKey: .code)
        self.etag = try values.decode(String.self, forKey: .etag)
    }
}
