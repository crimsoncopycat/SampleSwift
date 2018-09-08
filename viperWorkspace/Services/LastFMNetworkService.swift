//
//  LastFMNetworkService.swift
//  viperWorkspace
//
//  Created by iulik on 9/7/18.
//  Copyright © 2018 iulik. All rights reserved.
//

import Foundation
protocol LastFMRequestPerformer {
    func getMostListenArtists(onSuccess: @escaping ([Artist]) -> Void,  onError: @escaping (ErrorType) -> Void)
}


final class LastFMNetworkService: LastFMRequestPerformer {
    private var baseUrl: String {
        return "http://ws.audioscrobbler.com/2.0/?method=chart.gettopartists&api_key=31a2411c7a96f5f64dca17d18184f0a5&format=json"
    }
    
    func getMostListenArtists(onSuccess: @escaping ([Artist]) -> Void, onError: @escaping (ErrorType) -> Void) {
        let onSuccess: (Any?) -> Void = { response in
            
            guard let artists = response.flatMap([Artist].decode) else {
                return onError(.responseParse)
            }
            onSuccess(artists)
        }
        
        let requestInput = RequestInputs(baseUrl: baseUrl,
                                         method: .get,
                                         onSuccess: onSuccess,
                                         onFailure: onError)
        _ = Request(inputs: requestInput, encoding: .string)
    }
}

