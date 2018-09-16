//
//  LastFMNetworkService.swift
//  viperWorkspace
//
//  Created by iulik on 9/7/18.
//  Copyright © 2018 iulik. All rights reserved.
//

import Foundation
protocol LastFMRequestPerformer {
    func getMostListenArtists(onSuccess: @escaping (Artists) -> Void,  onError: @escaping (ErrorType) -> Void)
    
    func getDetailedInfoForArtist(artistName: String, onSuccess: @escaping (ArtistInfo) -> Void, onError: @escaping (ErrorType) -> Void)
}



final class LastFMNetworkService: LastFMRequestPerformer {
    private var path: String = ""
    private var baseUrl: String {
        return "http://ws.audioscrobbler.com/2.0/?method=\(self.path)&api_key=31a2411c7a96f5f64dca17d18184f0a5&format=json"
    }
    
    func getMostListenArtists(onSuccess: @escaping (Artists) -> Void, onError: @escaping (ErrorType) -> Void) {
        let onSuccess: (Any?) throws -> Void = { response in
            do {
                let artists = try Artists.decode(response)
                onSuccess(artists)
            } catch let error {
                print(error)
            }
        }
        
        self.path = "chart.gettopartists"
        let requestInput = RequestInputs(baseUrl: baseUrl,
                                         method: .get,
                                         onSuccess: onSuccess,
                                         onFailure: onError)
        _ = Request(inputs: requestInput, encoding: .string)
    }
    
    func getDetailedInfoForArtist(artistName: String,onSuccess: @escaping (ArtistInfo) -> Void, onError: @escaping (ErrorType) -> Void) {
        let onSuccess: (Any?) throws -> Void = { response in
            do {
                let artistInfo = try ArtistWrapper.decode(response)
                onSuccess(artistInfo.artist)
            } catch let error {
                print(error)
            }
        }
        
        self.path = "artist.getinfo&artist=\(artistName)".replacingOccurrences(of: " ", with: "%20")
        let requestInput = RequestInputs(baseUrl: baseUrl,
                                         method: .get,
                                         onSuccess: onSuccess,
                                         onFailure: onError)
        _ = Request(inputs: requestInput, encoding: .string)
    }
}

