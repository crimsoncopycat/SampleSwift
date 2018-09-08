//
//  RequestModuleFacade.swift
//  viperWorkspace
//
//  Created by iulik on 9/7/18.
//  Copyright © 2018 iulik. All rights reserved.
//

import Foundation

protocol RequestModuleFacadeProtocol {
    func getMostListenArtists(onSuccess: @escaping ([Artist]) -> Void, onError: @escaping (ErrorType) -> Void)
}

final class RequestModuleFacade: RequestModuleFacadeProtocol {
    var lastFMNetworkService: LastFMNetworkService!
    init(lastFMNetworkService: LastFMNetworkService) {
        self.lastFMNetworkService = lastFMNetworkService
    }
    
    func getMostListenArtists(onSuccess: @escaping ([Artist]) -> Void, onError: @escaping (ErrorType) -> Void) {
        self.lastFMNetworkService.getMostListenArtists(onSuccess: onSuccess, onError: onError)
    }
    
}
