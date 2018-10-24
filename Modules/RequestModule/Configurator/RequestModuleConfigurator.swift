//
//  RequestModuleRequestModuleConfigurator.swift
//  viperWorkspace
//
//  Created by iulik on 06/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//

import UIKit

class RequestModuleModuleConfigurator {
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? MostPopularArtistsViewController {
            configure(viewController: viewController)
        }
    }

    func configure(viewController: MostPopularArtistsViewController) {
        let router = MostPopularArtistsRouter()
        let presenter = MostPopularArtistsPresenter()
        let interactor = MostPopularArtistsInteractor()
        presenter.view = viewController
        presenter.router = router
        interactor.output = presenter
        interactor.facade = RequestModuleFacade(lastFMNetworkService: LastFMNetworkService())
        presenter.interactor = interactor
        viewController.output = presenter
    }

}
