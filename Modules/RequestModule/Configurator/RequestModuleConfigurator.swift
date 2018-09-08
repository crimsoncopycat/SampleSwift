//
//  RequestModuleRequestModuleConfigurator.swift
//  viperWorkspace
//
//  Created by iulik on 06/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//

import UIKit

protocol IBViperConfigurator {
    func configure(viewController: RequestModuleViewController)
}

class RequestModuleModuleConfigurator: IBViperConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? RequestModuleViewController {
            configure(viewController: viewController)
        }
    }

    func configure(viewController: RequestModuleViewController) {
        let router = RequestModuleRouter()
        let presenter = RequestModulePresenter()
        let interactor = RequestModuleInteractor()
        presenter.view = viewController
        presenter.router = router
        interactor.output = presenter
        interactor.facade = RequestModuleFacade(lastFMNetworkService: LastFMNetworkService())
        presenter.interactor = interactor
        viewController.output = presenter
    }

}
