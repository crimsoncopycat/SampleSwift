//
//  RequestModuleRequestModuleInitializer.swift
//  viperWorkspace
//
//  Created by iulik on 06/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//

import UIKit

class RequestModuleModuleInitializer {
    static func setup() -> UINavigationController {
        let requestmoduleViewController = MostPopularArtistsViewController.instantiate()
        let configurator = RequestModuleModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: requestmoduleViewController)
        return requestmoduleViewController.wrapWithNavigationController()
    }
}

extension UIViewController {
    public func wrapWithNavigationController()-> UINavigationController{
        let navigationController = UINavigationController(rootViewController: self)
        return navigationController
    }
}
