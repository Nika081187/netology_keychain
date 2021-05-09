//
//  Tabbar.swift
//  com.work.with.filemanager
//
//  Created by v.milchakova on 08.05.2021.
//

import UIKit

class Tabbar: UIViewController, UITabBarDelegate {

    let tabBar = UITabBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.delegate = self
        addTabbar()
    }

    func addTabbar() -> Void {

        view.backgroundColor = .white
        
        let item1 = UITabBarItem(title: "Файлы", image: nil, tag: 1)
        let item2 = UITabBarItem(title: "Настройки", image: nil, tag: 2)

        tabBar.items = [item1, item2]
        tabBar.selectedItem = item1

        view.addSubview(tabBar)
        tabBar.toAutoLayout()

        NSLayoutConstraint.activate([
            tabBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            tabBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func tabBar(_ tabBar: UITabBar, willEndCustomizing items: [UITabBarItem], changed: Bool) {
        navigationController?.pushViewController(ViewController(), animated: true)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.title {
        case "Файлы":
            let vc = ViewController()
            vc.tabBarController?.tabBar.isHidden = false
            navigationController?.pushViewController(vc, animated: true)
        case "Настройки":
            let vc = Settings()
            vc.tabBarController?.tabBar.isHidden = false
            navigationController?.pushViewController(vc, animated: true)
        default:
            fatalError("Unknown tab bar item!")
        }
    }
}
