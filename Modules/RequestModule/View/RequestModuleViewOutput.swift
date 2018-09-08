//
//  RequestModuleRequestModuleViewOutput.swift
//  viperWorkspace
//
//  Created by iulik on 06/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//
import UIKit

protocol RequestModuleViewOutput {

    /**
        @author iulik
        Notify presenter that view is ready
    */

    func viewIsReady()
    func didTapArtistCell(_ indexPath: IndexPath)
}
