//
//  DetailViewController.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 12.11.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
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
        view.backgroundColor = .systemMint
        title = viewModel.title
    }
}

