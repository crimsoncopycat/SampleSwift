//
//  RequestModuleRequestModuleViewController.swift
//  viperWorkspace
//
//  Created by iulik on 06/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//

import UIKit

final class RequestModuleViewController: UIViewController, RequestModuleViewInput, StoryboardInstantiable {

    var output: RequestModuleViewOutput!

    static var storyboardName: String {
        return String(describing: self)
    }

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: RequestModuleViewInput
    func setupInitialState() {
        
    }
}

extension RequestModuleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier) as? ArtistTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}

extension RequestModuleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
