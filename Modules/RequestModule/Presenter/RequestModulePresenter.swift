//
//  RequestModuleRequestModulePresenter.swift
//  viperWorkspace
//
//  Created by iulik on 06/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//
import UIKit

class RequestModulePresenter: RequestModuleModuleInput, RequestModuleViewOutput, RequestModuleInteractorOutput {
    func didObtainMostListenArtists(_ artists: [Artist]) {
        
    }
    
    
    func didTapArtistCell(_ indexPath: IndexPath) {
        
    }
    
    func didObtainDataWithError(error: ErrorType) {
        
    }
    

    weak var view: RequestModuleViewInput!
    var interactor: RequestModuleInteractorInput!
    var router: RequestModuleRouterInput!

    func viewIsReady() {
        interactor.getMostListenArtists()
    }
}
