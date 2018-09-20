//
//  RequestModuleRequestModuleViewController.swift
//  viperWorkspace
//
//  Created by iulik on 06/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//

import UIKit

protocol MostPopularArtistsViewInput: class {
    func setupInitialState()
    func showError(_ error: ErrorType)
    func configureTableViewWithData(_ artists: Artists)
}

protocol MostPopularArtistsViewOutput {
    func viewIsReady()
    func getMostPopularArtists()
    func didTapArtistCell(_ indexPath: IndexPath, artistName: String)
}

final class MostPopularArtistsViewController: UIViewController, MostPopularArtistsViewInput, StoryboardInstantiable {
    var output: MostPopularArtistsViewOutput!

    static var storyboardName: String {
        return String(describing: self)
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = 100
            tableView.separatorStyle = .none
        }
    }
    var artistViewModels: [MostListenArtistViewModel]! {
        didSet {
            self.activityIndicator.isHidden = !self.activityIndicator.isHidden
        }
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        output.viewIsReady()
    }


    func setupInitialState() {
        self.title = Constants.mostListenArtistsModuleTitle.rawValue
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    func configureTableViewWithData(_ artists: Artists) {
        DispatchQueue.main.async {
            self.artistViewModels = artists.artists.artist.map{ MostListenArtistViewModel(artist: $0)}
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: ErrorType) {
        DispatchQueue.main.async { [weak self] in
            self?.artistViewModels = nil
            let alert = UIAlertController.tryToReloadAlert(message: error.message, reloadHandler: { alert in
                self?.output.getMostPopularArtists()
            })
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

extension MostPopularArtistsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = artistViewModels else {
            return 0
        }
        return artistViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier) as? ArtistTableViewCell else {
            return UITableViewCell()
        }
        cell.mostListenViewModel = artistViewModels[indexPath.item]
        return cell
    }
}

extension MostPopularArtistsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = artistViewModels else {
            return
        }
        output.didTapArtistCell(indexPath, artistName: artistViewModels[indexPath.row].artistName)
    }
}
