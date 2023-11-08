//
//  ViewController.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 08.11.2023.
//

import UIKit

final class TabBarController: UITabBarController {
// MARK: - life cycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        drawBezier()
    }
}

// MARK: - extension
extension TabBarController{
// MARK: - flow func
    
    func makeVC(vc: UIViewController, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        vc.tabBarItem.image = image
        vc.tabBarItem.selectedImage = selectedImage
        return vc
    }
    
    func generateTabBar() {
        let nav1 = UINavigationController(rootViewController: CharViewController())
        let nav2 = UINavigationController(rootViewController: LogOutViewController())
        
        
        viewControllers = [
        makeVC(vc: nav1, image: UIImage(systemName: "character.book.closed"), selectedImage: UIImage(systemName: "character.book.closed.fill")),
        makeVC(vc: nav2, image: UIImage(systemName: "figure.run.circle"), selectedImage: UIImage(systemName: "figure.run.circle.fill"))
        ]
    }
    
    func drawBezier() {
        let positionX: CGFloat = 40
        let positionY: CGFloat = -15
        let width = tabBar.bounds.width - positionX * 2
        let height = 68.0
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionX, y: positionY, width: width, height: height), cornerRadius: 24)
        roundLayer.path = bezierPath.cgPath
        
        roundLayer.shadowColor = UIColor.black.cgColor
        roundLayer.shadowOffset = CGSize(width: 4, height: 4)
        roundLayer.shadowOpacity = 0.8
        roundLayer.shadowRadius = 4
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 80
        roundLayer.fillColor = UIColor.white.cgColor
    }
    
}
