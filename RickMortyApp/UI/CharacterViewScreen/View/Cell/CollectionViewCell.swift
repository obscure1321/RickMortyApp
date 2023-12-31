//
//  CollectionViewCell.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 10.11.2023.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    // MARK: - properties
    private let mainView: UIView = {
        let element = UIView()
        element.backgroundColor = .systemGroupedBackground
        element.layer.cornerRadius = 12
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.shadowColor = UIColor.black.cgColor
        element.layer.shadowOffset = CGSize(width: 2, height: 2)
        element.layer.shadowRadius = 2
        element.layer.shadowOpacity = 0.8
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor.systemGray.cgColor
        return element
    }()
    
    let imgView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleToFill
        element.clipsToBounds = true
        element.layer.cornerRadius = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let nameLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .left
        element.font = UIFont.boldSystemFont(ofSize: element.font.pointSize)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let statusLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .left
        element.font = UIFont.systemFont(ofSize: element.font.pointSize, weight: .thin)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - life cycle func
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    // MARK: - flow funcs
    func configure(with viewModel: CollectionVIewCellViewModel) {
        setConstraints()
        nameLabel.text = viewModel.characterName
        statusLabel.text = "Status: \(viewModel.characterStatusText)"
        viewModel.fetchImg { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imgView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
    
    func setViews() {
        addSubview(mainView)
        mainView.addSubview(imgView)
        mainView.addSubview(nameLabel)
        mainView.addSubview(statusLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            imgView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
            imgView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 5),
            imgView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            imgView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.7),
            
            nameLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            nameLabel.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.12),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            statusLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 5),
            statusLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            statusLabel.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.07)
        ])
    }
}
