//
//  Artist.swift
//  MusicByLocation
//
//  Created by Jasper Hersov on 17/05/2021.
//

import Foundation

struct Artist: Codable, Hashable {
    var name: String
    var url: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "artistName"
        case url = "artistLinkUrl"
    }
}
