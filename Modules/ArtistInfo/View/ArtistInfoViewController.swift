//
//  ArtistInfoArtistInfoViewController.swift
//  viperWorkspace
//
//  Created by iulik on 08/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//

import UIKit

protocol ArtistInfoViewOutput {
    func viewIsReady()
    func getArtistInfoOnInitialAcces(with artistName: String)
}

protocol ArtistInfoViewInput: class {
    func setupInitialState()
    func configureViewWithData(with artistInfo: ArtistInfo)
    func errorFetchArtistInfo(with error: ErrorType)
}

final class ArtistInfoViewController: UIViewController, ArtistInfoViewInput, StoryboardInstantiable {
    var output: ArtistInfoViewOutput!

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    static var storyboardName: String {
        return String(describing: self)
    }
    
    var artistInfo: ArtistInfo! {
        didSet {
            activityIndicator.isHidden = !activityIndicator.isHidden
        }
    }
    var artistNameString: String!
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        output.viewIsReady()
        output.getArtistInfoOnInitialAcces(with: self.artistNameString)
    }


    // MARK: ArtistInfoViewInput
    func setupInitialState() {
        self.title = artistNameString
    }
    
    func configureViewWithData(with artistInfo: ArtistInfo) {
        self.artistInfo = artistInfo
        self.textView.text = artistInfo.bio.summary
        self.artistName.text = artistInfo.name
        guard let imageURL = artistInfo.image.last?.text , let url = URL(string: imageURL) else {
            return
        }
        artistImage.af_setImage(withURL: url)
    }
    
    func errorFetchArtistInfo(with error: ErrorType) {
        DispatchQueue.main.async { [weak self] in
            self?.artistInfo = nil
            let alert = UIAlertController.tryToReloadAlert(message: error.message, reloadHandler: { alert in
                guard let artistNameString = self?.artistNameString else {
                    return
                }
                self?.output?.getArtistInfoOnInitialAcces(with: artistNameString)
            })
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    deinit {
        artistImage.image = nil
    }
}
