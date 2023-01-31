//
//  ViewController.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import UIKit

class SingerTracksViewController: UIViewController {
    
#warning("add check dublication")
#warning(" <Notification about changes>, synchronization between UI layer and Data model ")
    
///    Which CoreData Stack I should select in this cases:
//    1 case:
///    We have Big Save, and Small Fetch
///
//    2 case:
///    We have Big Save, and Big Fetch
///
///    Describe + and - each of the approach
///    Have many contexts need depend of the approach
///    Need temporary or live contexts
///    Parent and Child Contexts or not

    
    private lazy var viewModel: SingerTracksViewModel = {
        let search = SearchSingerTracksUseCase()
        let storage = StorageSingerTracksUseCase(storageRepository: PersistentStorageRepository())
        let dataProvider = SingerTrackDataProvider(useCase: search, useCase: storage)
        
        let view = SingerTracksViewModel(dataProvider)
        
        return view
    }()
    
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
    
    private lazy var button: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Download 1 Song", for: .normal)
        view.tintColor = .gray
        view.backgroundColor = .white
        view.setTitleColor(.black, for: .normal)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.red.cgColor
        
        view.addAction(UIAction(handler: { [weak self] _ in
            self?.viewModel.downloadRandomSingerTrack()
        }), for: .touchUpInside)
        
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
        
        viewModel.dataSource = { state in
            switch state {
            case .inProgress:
                DispatchQueue.main.async { [weak self] in
                    self?.loader.startAnimating()
                }
            case .completed:
                DispatchQueue.main.async { [weak self] in
                    self?.loader.stopAnimating()
                    self?.refreshControll.endRefreshing()
                    self?.tableView.reloadData()
                }
            case .failure(let failure):
                DispatchQueue.main.async { [weak self] in
                    self?.loader.stopAnimating()
                    self?.refreshControll.endRefreshing()
                    self?.presentAlertController(msg: failure.localizedDescription, title: "Error")
                }
            }
        }
        
        viewModel.fetchListOfSongsFromStorage()
        
    }
    
    
    
    private func initUIComponents(){
        view.backgroundColor = .white
        
        view.addSubview(button)
        view.addSubview(loader)
        view.addSubview(tableView)
        
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: loader.topAnchor, constant: -10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    @objc func refreshControlAction() {
        viewModel.fetchListOfSongsFromStorage()
    }
    
    private func presentAlertController(msg: String, title: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
        
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

