//
//  RequestModuleRequestModuleInitializer.swift
//  viperWorkspace
//
//  Created by iulik on 06/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//

import UIKit

class RequestModuleModuleInitializer {
    static func setup() -> RequestModuleViewController {
        let requestmoduleViewController = RequestModuleViewController.instantiate()
        let configurator = RequestModuleModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: requestmoduleViewController)
        return requestmoduleViewController
    }
}
