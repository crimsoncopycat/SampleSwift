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
            tableView.delegate = self
            tableView.rowHeight = 100
            tableView.separatorStyle = .none
        }
    }
    
    var tableDataSource : GenericTableViewDataSource<MostListenArtistViewModel>!
    
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
            self.tableDataSource = .make(for: self.artistViewModels)
            self.tableView.dataSource = self.tableDataSource
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

extension MostPopularArtistsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = artistViewModels else {
            return
        }
        output.didTapArtistCell(indexPath, artistName: artistViewModels[indexPath.row].artistName)
    }
}

extension GenericTableViewDataSource where Model == MostListenArtistViewModel {
    static func make(for artists: [MostListenArtistViewModel],
                     reuseIdentifier: String = ArtistTableViewCell.identifier) -> GenericTableViewDataSource {
        return GenericTableViewDataSource(
            models: artists,
            reuseIdentifier: reuseIdentifier
        ) { (artist, cell) in
            guard let cell = cell as? ArtistTableViewCell else {
                return
            }
            
            cell.mostListenViewModel = artist
        }
    }
}
