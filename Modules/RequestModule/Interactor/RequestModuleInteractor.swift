//
//  RequestModuleRequestModuleInteractor.swift
//  viperWorkspace
//
//  Created by iulik on 06/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//

class RequestModuleInteractor: RequestModuleInteractorInput {
    weak var output: RequestModuleInteractorOutput!
    var facade: RequestModuleFacade!
    
    func getMostListenArtists() {
        facade.getMostListenArtists(onSuccess: {
            [weak self] artists in
            self?.output.didObtainMostListenArtists(artists)
        }, onError: {
            [weak self] error in
            self?.output.didObtainDataWithError(error: error)
        })
    }
}
