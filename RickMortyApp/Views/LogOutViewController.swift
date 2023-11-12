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
        view.backgroundColor = .white
        setNavBar()
    }

// MARK: - flow func
    private func setNavBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: ( view.frame.height / 6.5)))
        navigationBar.backgroundColor = .systemTeal
        let navigationItem = UINavigationItem.init(title: "Log Out")
        navigationBar.items = [navigationItem]
        navigationItem.largeTitleDisplayMode = .automatic
        navigationBar.prefersLargeTitles = true
        
        view.addSubview(navigationBar)
    }
}
