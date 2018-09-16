//
//  RequestModuleRequestModuleRouter.swift
//  viperWorkspace
//
//  Created by iulik on 06/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//
import UIKit

protocol RequestModuleRouterInput {
    func openArtistInfoModule(_ artistName: String)
}

class MostPopularArtistsRouter: RequestModuleRouterInput {
    func openArtistInfoModule(_ artistName: String) {
        let controller = ArtistInfoModuleInitializer.setup(with: artistName)
        guard let navController = UIApplication.topViewController()?.navigationController else {
            fatalError("Parent view controller don't have UINavigationController")
        }
        navController.pushViewController(controller, animated: true)
    }
}
