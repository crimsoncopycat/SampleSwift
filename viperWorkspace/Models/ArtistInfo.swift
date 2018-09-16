//
//  ArtistInfo.swift
//  viperWorkspace
//
//  Created by iulik on 9/8/18.
//  Copyright © 2018 iulik. All rights reserved.
//

import Foundation
struct ArtistWrapper: Codable {
    var artist: ArtistInfo
}
struct ArtistInfo: Codable {
    var name: String
    var mbid: String?
    var url: String
    var image: [ArtistImage]
    var streamable: String
    var ontour: String
    var stats: ArtistStats
    var similar: ArtistKeySimilar
    var tags: ArtistTagsKey
    var bio: ArtistBio
}

struct ArtistKeySimilar: Codable {
    var artist: [ArtistSimilar]
}

struct ArtistTagsKey: Codable {
    var tag: [ArtistTag]
}

struct ArtistTag: Codable {
    var name: String
    var url: String
}

struct ArtistSimilar: Codable {
    var name: String
    var url: String
    var image: [ArtistImage]
}

struct ArtistStats: Codable {
    var listeners: String
    var playcount: String
}

struct ArtistBio : Codable {
    var links: String?
    var published: String?
    var summary: String
    var content: String
    enum CodingKeys: String, CodingKey {
        case summary, content
    }
}
