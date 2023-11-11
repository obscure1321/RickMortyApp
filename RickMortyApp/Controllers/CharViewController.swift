//
//  CharViewController.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 08.11.2023.
//

import UIKit

final class CharViewController: UIViewController {
// MARK: - properties
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let element = UICollectionView(frame: .zero, collectionViewLayout: layout)
        element.backgroundColor = .clear
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

// MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
// MARK: - flow funcs
    private func setUp() {
        view.backgroundColor = .white
        setNavBar()
        setCollection()
        addViews()
        setConstraints()
    }
    
    private func addViews() {
        view.addSubview(collectionView)
    }
    
    private func setNavBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: ( view.frame.height / 6.5)))
        navigationBar.backgroundColor = .systemTeal
        let navigationItem = UINavigationItem.init(title: "Characters")
        navigationBar.items = [navigationItem]
        navigationItem.largeTitleDisplayMode = .automatic
        navigationBar.prefersLargeTitles = true
        navigationBar.shadowImage = UIImage()
        
        view.addSubview(navigationBar)
    }
    
    private func setCollection() {
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.frame.height / 6.5 + 10)),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - extension
extension CharViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.configure()
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
    
}
