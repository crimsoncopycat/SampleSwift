//
//  RequestModuleRequestModuleInteractor.swift
//  viperWorkspace
//
//  Created by iulik on 06/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//
protocol MostPopularArtistsInteractorOutput: class {
    func didObtainMostListenArtists(_ artists: Artists)
    func didObtainDataWithError(error: ErrorType)
}

protocol RequestModuleInteractorInput {
    func getMostListenArtists()
    //    func getInfoForArtist(_ artistName: String)
}

class MostPopularArtistsInteractor: RequestModuleInteractorInput {
    weak var output: MostPopularArtistsInteractorOutput!
    var facade: RequestModuleFacadeProtocol!
    
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
