//
//  ViewController.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import UIKit

protocol SingerTracksDelegate: AnyObject {
    func coordinator(didSelect trackId: String)
}

#warning("Q: - _SingerTracksDelegate")
protocol _SingerTracksDelegate: AnyObject {
    associatedtype TrackID
    func coordinator(didSelect trackId: TrackID)
}

class SingerTracksViewController: UIViewController {
    /// Navigation
    weak var coordinatorDelegate: SingerTracksDelegate?
    
    /// Data Properties
    private var data: Array<PresentationModel.SingerTrack> = Array() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.loader.stopAnimating()
                self?.tableView.reloadData()
            }
        }
    }
    
    /// View Models
    var viewModel: SingerTracksViewModelInterface!
    
    /// UI Properties
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(SingerTrackListCell.self, forCellReuseIdentifier: SingerTrackListCell.identifier)
        return view
    }()
    
    private lazy var button: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle(Constants.SingerTracksScreen.downloadButtonTitle, for: .normal)
        view.tintColor = .gray
        view.backgroundColor = .white
        view.setTitleColor(.black, for: .normal)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.red.cgColor
        
        view.addAction(UIAction(handler: { [weak self] _ in
            self?.viewModel.downloadSong()
            self?.loader.startAnimating()
        }), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUIComponents()
        
        viewModel.dataSource = { [weak self] result in
            switch result {
            case .success(let success):
                self?.data = success
            case .failure(let failure):
                self?.presentAlertController(msg: failure.localizedDescription, title: Constants.Alert.alertTitle)
            }
        }
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
        loader.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10).isActive = true
        
        tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

// MARK: Data Source
extension SingerTracksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinatorDelegate?.coordinator(didSelect: data[indexPath.row].trackId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SingerTrackListCell.identifier, for: indexPath)
        
        let data = data[indexPath.row]
        let configurator = SingerTrackListConfigurator(model: data)
        cell.contentConfiguration = configurator
        
        return cell
    }
}

