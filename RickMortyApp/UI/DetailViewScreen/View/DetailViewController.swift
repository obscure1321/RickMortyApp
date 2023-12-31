//
//  DetailViewController.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 12.11.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    // MARK: - variables
    var episodesArray: [String] = []
    var episodesRawArray: [String] = []
    var genderText = ""
    var statusText: Status.RawValue = ""
    var locationText = ""
    var imageUrl = ""
    
    // MARK: - properties
    private let imgView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleToFill
        element.backgroundColor = .systemMint
        element.clipsToBounds = true
        element.layer.cornerRadius = 20
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let genderLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.font = UIFont.boldSystemFont(ofSize: element.font.pointSize)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let statusLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.font = UIFont.boldSystemFont(ofSize: element.font.pointSize)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let locationLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.font = UIFont.boldSystemFont(ofSize: element.font.pointSize)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let episodesLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.text = "Episodes with character:"
        element.font = UIFont.boldSystemFont(ofSize: element.font.pointSize)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let episodesTableView: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .clear
        element.alwaysBounceVertical = true
        element.separatorStyle = .none
        return element
    }()
    
    private let viewModel: DetailViewViewModel
    
    // MARK: - init
    init(viewModel: DetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - life cycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setDelegate()
        setEpisodesArray()
        setLabels()
    }
    
    override func viewWillLayoutSubviews() {
        setConstraints()
    }
    
    // MARK: - flow funcs
    private func configureView(){
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(imgView)
        view.addSubview(genderLabel)
        view.addSubview(statusLabel)
        view.addSubview(locationLabel)
        view.addSubview(episodesLabel)
        view.addSubview(episodesTableView)
    }
    
    private func setEpisodesArray() {
        for episode in episodesArray {
            if let lasIndex = episode.lastIndex(of: "/") {
                let result = String(episode.suffix(from: episode.index(after: lasIndex)))
                episodesRawArray.append(result)
            }
        }
    }
    
    private func setLabels() {
        genderLabel.text = "Gender: \(genderText)"
        statusLabel.text = "Status: \(statusText)"
        locationLabel.text = " Location: \(locationText)"
        
        if let url = URL(string: imageUrl) {
            loadImage(from: url) { image in
                if let image = image {
                    self.imgView.image = image
                } else {
                    return
                }
            }
        }
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Failed to load image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    private func setDelegate() {
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        episodesTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            imgView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            genderLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 10),
            genderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            genderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            genderLabel.heightAnchor.constraint(equalTo: statusLabel.heightAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 10),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            statusLabel.heightAnchor.constraint(equalTo: genderLabel.heightAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            locationLabel.heightAnchor.constraint(equalTo: statusLabel.heightAnchor),
            
            episodesLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            episodesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            episodesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            episodesLabel.heightAnchor.constraint(equalTo: statusLabel.heightAnchor),
            
            episodesTableView.topAnchor.constraint(equalTo: episodesLabel.bottomAnchor, constant: 10),
            episodesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            episodesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            episodesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

// MARK: - extension
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodesRawArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = episodesTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.reuseCell(value: episodesRawArray[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.height / 5
    }
}
