//
//  DetailViewController.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 12.11.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    var episodesArray: [String] = []
    var genderText = ""
    var statusText: Status.RawValue = ""
    var locationText = ""
    var imageUrl = ""
    
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
        element.backgroundColor = .systemMint
        element.alwaysBounceVertical = true
        element.separatorStyle = .none
        return element
    }()
    
    private let viewModel: DetailViewViewModel
    
    init(viewModel: DetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
        setLabels()
    }
    
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
