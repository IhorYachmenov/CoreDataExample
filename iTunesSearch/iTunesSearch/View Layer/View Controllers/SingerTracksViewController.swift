//
//  ViewController.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import UIKit

#warning("generic query")

#warning("dependency in some another place, that in VC")
// Level 2

#warning("add check dublication")
#warning("detail screen with more data, observe data, navigation")

class SingerTracksViewController: UIViewController {
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
//    var viewModel: SingerTracksViewModelInterface = DependencyFactory.SingerTrackViewModel.make() as! SingerTracksViewModelInterface
    
    /// UI Properties
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(TrackListCell.self, forCellReuseIdentifier: TrackListCell.identifier)
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
                self?.presentAlertController(msg: failure.localizedDescription, title: "Error")
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
        loader.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: loader.topAnchor, constant: -10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
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
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackListCell.identifier, for: indexPath)
        
        let data = data[indexPath.row]
        
        let configurator = TrackListConfigurator(model: data)
        
        cell.contentConfiguration = configurator
        
        return cell
    }
}

