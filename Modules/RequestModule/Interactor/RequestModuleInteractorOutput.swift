//
//  RequestModuleRequestModuleInteractorOutput.swift
//  viperWorkspace
//
//  Created by iulik on 06/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//

import Foundation

protocol RequestModuleInteractorOutput: class {
    func didObtainMostListenArtists(_ artists: [Artist])
    func didObtainDataWithError(error: ErrorType)
}
