//
//  ViewController.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import UIKit

class SingerTracksViewController: UIViewController {
    
    #warning("add check duplication")
    
    
    #warning("synchronization between UI layer and Data model")
    #warning(" <Notification about changes> ")
    
    private lazy var viewModel = SingerTracksViewModel()
    
    private lazy var refreshControll = UIRefreshControl()
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(TrackListCell.self, forCellReuseIdentifier: TrackListCell.identifier)
        view.refreshControl = refreshControll
        refreshControll.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
        return view
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUIComponents()
        
        viewModel.networkDataSource = { [weak self] networkState, result in
            switch networkState {
            case .InProgress:
                DispatchQueue.main.async { [weak self] in
                    self?.loader.startAnimating()
                }
            case .Completed:
                self?.networkDataSourceAction(result!)
            }
        }
 
        viewModel.storageDataSource = { [weak self] failure in
            DispatchQueue.main.async {
                self?.storageDataSouceAction(failure)
            }
        }
        
        viewModel.findRandomArtistTracks()
        viewModel.fetchSingerTracks()
        
    }
    
  
    
    private func initUIComponents(){
        view.backgroundColor = .white
        
        view.addSubview(loader)
        view.addSubview(tableView)
        
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: loader.topAnchor, constant: -10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    @objc func refreshControlAction() {
        viewModel.fetchSingerTracks()
    }
    
    private func presentAlertController(msg: String, title: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    private func networkDataSourceAction(_ result: Result<String, ServiceError>) {
        switch result {
        case .success(let success):
            DispatchQueue.main.async { [weak self] in
                self?.loader.stopAnimating()
                self?.presentAlertController(msg: success, title: "Alert")
            }
            
        case .failure(let failure):
            DispatchQueue.main.async { [weak self] in
                self?.loader.stopAnimating()
                self?.presentAlertController(msg: failure.localizedDescription, title: "Error")
            }
        }
        
    }
    
    private func storageDataSouceAction(_ failure: StorageError?) {
        
        guard failure == nil else {
            presentAlertController(msg: failure!.localizedDescription, title: "Error")
            return
        }
        refreshControll.endRefreshing()
        tableView.reloadData()
    }
}

// MARK: Data Source
extension SingerTracksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackListCell.identifier, for: indexPath)
    
        var configurator = TrackListConfigurator()
        configurator.singerName = viewModel.data[indexPath.row].singerName
        configurator.trackName = viewModel.data[indexPath.row].trackName
        configurator.country = viewModel.data[indexPath.row].country
        configurator.trackPrice = viewModel.data[indexPath.row].trackPrice
        cell.contentConfiguration = configurator
        
        return cell
    }
    
}

