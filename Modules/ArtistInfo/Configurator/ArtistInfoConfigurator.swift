//
//  ArtistInfoArtistInfoConfigurator.swift
//  viperWorkspace
//
//  Created by iulik on 08/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//

import UIKit

class ArtistInfoModuleConfigurator {
    static func configure(with viewController: ArtistInfoViewController) {
        let presenter = ArtistInfoPresenter()
        presenter.view = viewController
        let interactor = ArtistInfoInteractor()
        interactor.output = presenter
        interactor.artistInfoFacade = ArtistInfoFacade(lastFMNetworkService: LastFMNetworkService())
        presenter.interactor = interactor
        viewController.output = presenter
    }
}
