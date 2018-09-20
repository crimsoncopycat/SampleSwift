//
//  ArtistInfoArtistInfoConfigurator.swift
//  viperWorkspace
//
//  Created by iulik on 08/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//

import UIKit

class ArtistInfoModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? ArtistInfoViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ArtistInfoViewController) {
        let presenter = ArtistInfoPresenter()
        presenter.view = viewController
        let interactor = ArtistInfoInteractor()
        interactor.output = presenter
        interactor.artistInfoFacade = ArtistInfoFacade(lastFMNetworkService: LastFMNetworkService())
        presenter.interactor = interactor
        viewController.output = presenter
    }

}
