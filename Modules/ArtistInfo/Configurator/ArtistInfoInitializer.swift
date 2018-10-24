//
//  ArtistInfoArtistInfoInitializer.swift
//  viperWorkspace
//
//  Created by iulik on 08/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//

import UIKit

class ArtistInfoModuleInitializer {
    static func setup(with artistName: String) -> ArtistInfoViewController {
        let artistinfoViewController = ArtistInfoViewController.instantiate()
        ArtistInfoModuleConfigurator.configure(with: artistinfoViewController)
        artistinfoViewController.artistNameString = artistName
        return artistinfoViewController
    }
}
