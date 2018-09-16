//
//  Artist.swift
//  viperWorkspace
//
//  Created by iulik on 9/7/18.
//  Copyright © 2018 iulik. All rights reserved.
//

import Foundation

struct Artists : Codable {
    var artists: ArtistKey
}

struct ArtistKey: Codable {
    var artist: [Artist]
}

struct Attributes: Codable {
    var page: String
    var perPage: String
    var totalPages: String
    var total: String
}

struct Artist: Codable {
    var name: String
    var playcount: String
    var listeners: String
    var mbid: String
    var url: String
    var streamable: String
    var image: [ArtistImage]
}

struct ArtistImage: Codable {
    var text: String
    var size: String
    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size
    }
}
