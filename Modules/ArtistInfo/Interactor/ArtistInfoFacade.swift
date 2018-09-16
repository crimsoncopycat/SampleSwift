//
//  ArtistInfoFacade.swift
//  viperWorkspace
//
//  Created by iulik on 9/8/18.
//  Copyright © 2018 iulik. All rights reserved.
//

import Foundation

protocol ArtistInfoFacadeProtocol {
    func getInfoDetailedInfoForArtist(_ artist: String, onSuccess: @escaping (ArtistInfo) -> Void, onError: @escaping (ErrorType) -> Void)
}

final class ArtistInfoFacade: ArtistInfoFacadeProtocol {
    var lastFMNetworkService: LastFMRequestPerformer!
    init(lastFMNetworkService: LastFMRequestPerformer) {
        self.lastFMNetworkService = lastFMNetworkService
    }
    
    func getInfoDetailedInfoForArtist(_ artist: String, onSuccess: @escaping (ArtistInfo) -> Void, onError: @escaping (ErrorType) -> Void) {
    self.lastFMNetworkService.getDetailedInfoForArtist(artistName: artist, onSuccess: onSuccess, onError: onError)
    }
}
