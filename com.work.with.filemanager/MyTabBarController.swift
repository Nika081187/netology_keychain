//
//  Tabbar.swift
//  com.work.with.filemanager
//
//  Created by v.milchakova on 08.05.2021.
//

import UIKit

class MyTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let filesTab = FilesViewController()
        let filesTabItem = UITabBarItem(title: "Files", image: nil, selectedImage: nil)
        
        filesTab.tabBarItem = filesTabItem
        
        let settingsTab = SettingsViewController()
        let settingsTabItem = UITabBarItem(title: "Settings", image: nil, selectedImage: nil)
        
        settingsTab.tabBarItem = settingsTabItem
        
        self.viewControllers = [filesTab, settingsTab]
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
}
