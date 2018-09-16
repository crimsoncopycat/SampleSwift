//
//  RequestModuleRequestModulePresenter.swift
//  viperWorkspace
//
//  Created by iulik on 06/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//
import UIKit
protocol MostPopularArtistsModuleInput: class {
    
}

final class MostPopularArtistsPresenter: MostPopularArtistsModuleInput, MostPopularArtistsViewOutput, MostPopularArtistsInteractorOutput {

    
    
    weak var view: MostPopularArtistsViewInput!
    var interactor: RequestModuleInteractorInput!
    var router: RequestModuleRouterInput!

    func viewIsReady() {
        self.interactor.getMostListenArtists()
    }
    
    func getMostPopularArtists() {
        self.interactor.getMostListenArtists()
    }
    
    func didObtainMostListenArtists(_ artists: Artists) {
        view.configureTableViewWithData(artists)
    }
    
    func didTapArtistCell(_ indexPath: IndexPath, artistName: String) {
        router.openArtistInfoModule(artistName)
    }
    
    func didObtainDataWithError(error: ErrorType) {
        view.showError(error)
    }
}
