//
//  TableViewCell.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 12.11.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
// MARK: - properties
    private let mainView: UIView = {
        let element = UIView()
        element.backgroundColor = .systemGroupedBackground
        element.layer.cornerRadius = 8
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.shadowColor = UIColor.black.cgColor
        element.layer.shadowOffset = CGSize(width: 2, height: 2)
        element.layer.shadowRadius = 2
        element.layer.shadowOpacity = 0.8
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor.systemGray.cgColor
        return element
    }()
    
    private let episodeValue: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.font = UIFont.boldSystemFont(ofSize: element.font.pointSize)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
// MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "TableViewCell")
        addSubview(mainView)
        mainView.addSubview(episodeValue)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            episodeValue.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
            episodeValue.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 5),
            episodeValue.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            episodeValue.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - flow func
    func reuseCell(value: String) {
        episodeValue.text = value
    }
}
