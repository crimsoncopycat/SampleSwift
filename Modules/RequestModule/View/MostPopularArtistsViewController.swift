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
    var artists: [Artist]! {
        didSet {
            self.activityIndicator.isHidden = !self.activityIndicator.isHidden
        }
    }
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        self.activityIndicator.startAnimating()
        output.viewIsReady()
    }


    // MARK: RequestModuleViewInput
    func setupInitialState() {
        self.title = Constants.mostListenArtistsModuleTitle.rawValue
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    func configureTableViewWithData(_ artists: Artists) {
        DispatchQueue.main.async {
            self.artists = artists.artists.artist
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: ErrorType) {
        DispatchQueue.main.async { [weak self] in
            self?.artists = nil
            let alert = UIAlertController.tryToReloadAlert(message: error.message, reloadHandler: { alert in
                self?.output.getMostPopularArtists()
            })
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

extension MostPopularArtistsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let artists = artists else {
            return 0
        }
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier) as? ArtistTableViewCell else {
            return UITableViewCell()
        }
        self.configureCell(in: cell, with: self.artists[indexPath.row])
        return cell
    }
    
    func configureCell(in cell: ArtistTableViewCell, with artist: Artist) {
        cell.artistName.text = artist.name
        cell.listeners.text = artist.listeners + " listeners"
        guard let url = URL(string: artist.image[2].text) else {
            return
        }
        cell.artistImage.af_setImage(withURL: url)
    }
}

extension MostPopularArtistsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let artists = artists else {
            return
        }
        output.didTapArtistCell(indexPath, artistName: artists[indexPath.row].name)
    }
}
