//
//  TrackListViewModel.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Domain_Layer

final class SingerTracksViewModel: SingerTracksViewModelInterface {
    /// Data Source
    var dataSource: ((Result<[PresentationModel.SingerTrack], Error>) -> ())?
    
    /// View Model properties
    private lazy var listOfSingers = ["Janet Jackson", "Eminem", "Katy Perry", "Lady Gaga", "Snoop Dogg", "Elvis Presley", "Taylor Swift", "Adele", "Beyonce", "Justin Bieber", "Ed Sheeran", "Rihanna", "Bruno Mars", "Kendrick Lamar", "Drake", "Nicki Minaj", "Kanye West", "Post Malone", "Cardi B", "Lizzo", "Shawn Mendes", "Ariana Grande", "Dua Lipa", "Harry Styles", "Billie Eilish", "The Weeknd", "Miley Cyrus", "Chris Brown", "Charlie Puth", "Khalid", "Zayn", "Selena Gomez", "Katy Perry", "Lil Nas X", "Doja Cat", "Olivia Rodrigo", "Camila Cabello", "Halsey", "The Chainsmokers", "Imagine Dragons", "Maroon 5", "The Beatles", "Elton John", "Michael Jackson", "Whitney Houston", "Prince", "Madonna", "David Bowie", "Queen", "Led Zeppelin", "AC/DC"]
 
    /// Use Cases
    private var singerTracksWorker: SingerTracksWorkerUseCaseInterface!
    
    init(useCase: SingerTracksWorkerUseCaseInterface) {
        singerTracksWorker = useCase
        
        useCase.subscribeOfData { [weak self] data in
            DispatchQueue.main.async {
                self?.dataSource?(.success(data.map { PresentationModel.SingerTrack(dataModel: $0) } ))
            }
        }
    }
    
    func downloadSong() {
        singerTracksWorker.downloadAndSaveSingerTrack(name: listOfSingers.randomElement() ?? "Janet Jackson") { [weak self] failure in
            if let failure = failure {
                DispatchQueue.main.async {
                    self?.dataSource?(.failure(failure))
                }
            }
        }
    }
}
