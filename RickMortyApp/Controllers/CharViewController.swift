//
//  CharViewController.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 08.11.2023.
//

import UIKit

final class CharViewController: UIViewController {
// MARK: - properties
    private let viewModel = CharacterViewModel()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let element = UICollectionView(frame: .zero, collectionViewLayout: layout)
        element.backgroundColor = .clear
        element.translatesAutoresizingMaskIntoConstraints = false
        element.showsVerticalScrollIndicator = false
        element.isHidden = true
        element.alpha = 0
        element.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        return element
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let element = UIActivityIndicatorView(style: .large)
        element.hidesWhenStopped = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

// MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUp()
    }
    
// MARK: - flow funcs
    private func setUp() {
        setNavBar()
        setCollection()
        addViews()
        setConstraints()
        spinner.startAnimating()
        viewModel.fetchCharacters()
    }
    
    private func addViews() {
        view.addSubview(spinner)
        view.addSubview(collectionView)
    }
    
    private func setNavBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: ( view.frame.height / 6.5)))
        navigationBar.backgroundColor = .systemTeal
        let navigationItem = UINavigationItem.init(title: "Characters")
        navigationBar.items = [navigationItem]
        navigationItem.largeTitleDisplayMode = .automatic
        navigationBar.prefersLargeTitles = true
        navigationBar.isTranslucent = true
        
        view.addSubview(navigationBar)
    }
    
    private func setCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//            self.spinner.stopAnimating()
//            
//            self.collectionView.isHidden = false
//            
//            UIView.animate(withDuration: 0.4) {
//                self.collectionView.alpha = 1
//            }
//        })
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 120),
            spinner.widthAnchor.constraint(equalToConstant: 120),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.frame.height / 6.5 + 10)),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func charView(
        _ charView: CharViewController,
        character: CharacterResult
    ) {
        let viewModel = DetailViewViewModel(character: character)
        let detailVC = DetailViewController(viewModel: viewModel)
        detailVC.genderText = character.gender?.rawValue ?? "Unknown"
        detailVC.statusText = character.status?.rawValue ?? "Unknown"
        detailVC.locationText = character.location?.name ?? "Unknown"
        detailVC.imageUrl = character.image ?? "https://rickandmortyapi.com/api/character/avatar/8.jpeg"
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - extension
extension CharViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CharacterViewModelProtocol {
    func didSelectCharacter(_ character: CharacterResult) {
        charView(self, character: character)
    }
    
    func didLoadInitialCharacters() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: self.viewModel.cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = Int((collectionView.frame.width - 10) / 2)
        let cellHeight = Int(view.frame.height / 3.5)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = viewModel.characters[indexPath.row]
        didSelectCharacter(character)
    }
}
