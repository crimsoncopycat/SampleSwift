//
//  RequestModuleFacade.swift
//  viperWorkspace
//
//  Created by iulik on 9/7/18.
//  Copyright © 2018 iulik. All rights reserved.
//

import Foundation

protocol RequestModuleFacadeProtocol {
    func getMostListenArtists(onSuccess: @escaping (Artists) -> Void, onError: @escaping (ErrorType) -> Void)
}

final class RequestModuleFacade: RequestModuleFacadeProtocol {
    var lastFMNetworkService: LastFMRequestPerformer!
    init(lastFMNetworkService: LastFMRequestPerformer) {
        self.lastFMNetworkService = lastFMNetworkService
    }
    
    func getMostListenArtists(onSuccess: @escaping (Artists) -> Void, onError: @escaping (ErrorType) -> Void) {
        self.lastFMNetworkService.getMostListenArtists(onSuccess: onSuccess, onError: onError)
    }
}

