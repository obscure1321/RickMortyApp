//
//  LogOutViewController.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 08.11.2023.
//

import UIKit

final class LogOutViewController: UIViewController {

// MARK: - life cycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setNavBar()
    }

// MARK: - flow func
    private func setNavBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: (view.frame.height / 6.5)))
        navigationBar.backgroundColor = .deepGreen
        
        let navigationItem = UINavigationItem(title: "Log Out")
        navigationItem.largeTitleDisplayMode = .automatic
        
        navigationBar.items = [navigationItem]
        navigationBar.prefersLargeTitles = true
        navigationBar.isTranslucent = true
        
        // Установите цвет текста для обычных и больших заголовков
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        view.addSubview(navigationBar)
    }
}
