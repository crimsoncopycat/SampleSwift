//
//  ArtistInfoArtistInfoPresenter.swift
//  viperWorkspace
//
//  Created by iulik on 08/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//
import UIKit

protocol ArtistInfoModuleInput: class {
    
}

class ArtistInfoPresenter: ArtistInfoModuleInput, ArtistInfoViewOutput, ArtistInfoInteractorOutput {
    weak var view: ArtistInfoViewInput!
    var interactor: ArtistInfoInteractorInput!

    func viewIsReady() {
       
    }
    
    func getArtistInfoOnInitialAcces(with artistName: String) {
        interactor.getArtistInfo(artistName)
    }
    
    func failWhenReceiveData(error: ErrorType) {
        self.view.errorFetchArtistInfo(with: error)
    }
    
    func didReceiveData(info: ArtistInfo) {
        DispatchQueue.main.async {
            self.view.configureViewWithData(with: info)
        }
    }
}
