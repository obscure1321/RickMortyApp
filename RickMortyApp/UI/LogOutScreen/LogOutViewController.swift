//
//  LogOutViewController.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 08.11.2023.
//

import UIKit

final class LogOutViewController: UIViewController {
    // MARK: - properties
    private let imgView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "goodbye")
        element.contentMode = .scaleToFill
        element.clipsToBounds = true
        element.layer.cornerRadius = 15
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("L O G   O U T", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.005332739092, green: 0.1982556581, blue: 0.1359425783, alpha: 1)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - life cycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK: - flow funcs
    private func setUpView() {
        view.backgroundColor = .systemBackground
        view.addSubview(imgView)
        view.addSubview(logOutButton)
        setNavBar()
        setConstraints()
        logOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
    }
    
    private func setNavBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: (view.frame.height / 6.5)))
        navigationBar.backgroundColor = #colorLiteral(red: 0.005332739092, green: 0.1982556581, blue: 0.1359425783, alpha: 1)
        
        let navigationItem = UINavigationItem(title: "Log Out")
        navigationItem.largeTitleDisplayMode = .automatic
        
        navigationBar.items = [navigationItem]
        navigationBar.prefersLargeTitles = true
        navigationBar.isTranslucent = true
        
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        view.addSubview(navigationBar)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgView.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.frame.height / 6.5 + 40)),
            imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor, multiplier: 1.2),
            
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 40),
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            logOutButton.heightAnchor.constraint(equalTo: imgView.widthAnchor, multiplier: 0.4)
        ])
    }
    
    // MARK: - objc func
    @objc func logOutTapped() {
        let vc = LoginScreenController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
        UserDefaults.standard.set(false, forKey: "Authorized")
    }
}
