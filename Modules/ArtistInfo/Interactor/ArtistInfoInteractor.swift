//
//  ArtistInfoArtistInfoInteractor.swift
//  viperWorkspace
//
//  Created by iulik on 08/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//

protocol ArtistInfoInteractorInput {
    var artistInfoFacade: ArtistInfoFacade! { get set }
    func getArtistInfo(_ artistName: String)
}

protocol ArtistInfoInteractorOutput: class {
    func failWhenReceiveData(error: ErrorType)
    func didReceiveData(info: ArtistInfo)
}

class ArtistInfoInteractor: ArtistInfoInteractorInput {
    weak var output: ArtistInfoInteractorOutput!
    var artistInfoFacade: ArtistInfoFacade!
    func getArtistInfo(_ artistName: String) {
        artistInfoFacade.getInfoDetailedInfoForArtist(artistName, onSuccess: {[weak self]
            artistInfo in
            self?.output.didReceiveData(info: artistInfo)
        }, onError: {
            [weak self] err in
            self?.output.failWhenReceiveData(error: err)
        })
    }
}
