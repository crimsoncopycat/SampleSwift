//
//  MostListenArtistViewModel.swift
//  viperWorkspace
//
//  Created by iulik on 9/20/18.
//  Copyright © 2018 iulik. All rights reserved.
//

import Foundation

struct MostListenArtistViewModel {
    let artistName: String
    let listeners: String
    let artistImageURL: String
    
    init(artist: Artist) {
        self.artistName = artist.name
        self.listeners = artist.listeners + " listeners"
        self.artistImageURL = artist.image[2].text
    }
}
