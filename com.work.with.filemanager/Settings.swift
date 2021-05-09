//
//  Settings.swift
//  com.work.with.filemanager
//
//  Created by v.milchakova on 08.05.2021.
//

import UIKit

class Settings: UIViewController {
    
    enum SettingType: String {
        case fileSorted
        case fileSizeShowed
        case changePassword
    }
    
    private var fileSorted: Bool = true
    private var fileSizeShowed: Bool = true
    private var changePassword: String = ""
    private let defaults = UserDefaults.standard
    
    private lazy var switchFileSorted: UISwitch = {
        let switchFileSorted = UISwitch(frame:CGRect(x: 150, y: 150, width: 0, height: 0))
        switchFileSorted.addTarget(self, action: #selector(self.switchFileSortedStateDidChange(_:)), for: .valueChanged)
        switchFileSorted.setOn(true, animated: false)
        switchFileSorted.toAutoLayout()
        return switchFileSorted
    }()
    
    private lazy var switchFileSortedLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "switch File Sorted"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    @objc func switchFileSortedStateDidChange(_ sender:UISwitch!) {
        if (sender.isOn == true) {
            print("UISwitch FileSorted state is now ON")
            setUserDefault(.fileSorted, value: true)
        }
        else {
            print("UISwitch FileSorted state is now Off")
            setUserDefault(.fileSorted, value: false)
        }
    }
    
    private lazy var switchFileSizeShowed: UISwitch = {
        let switchFileSizeShowed = UISwitch(frame:CGRect(x: 150, y: 150, width: 0, height: 0))
        switchFileSizeShowed.addTarget(self, action: #selector(self.switchFileSizeShowedStateDidChange(_:)), for: .valueChanged)
        switchFileSizeShowed.setOn(true, animated: false)
        switchFileSizeShowed.toAutoLayout()
        return switchFileSizeShowed
    }()
    
    private lazy var switchFileSizeShowedLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "switch File Size Showed"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    @objc func switchFileSizeShowedStateDidChange(_ sender:UISwitch!) {
        if (sender.isOn == true) {
            print("UISwitch FileSize state is now ON")
            setUserDefault(.fileSizeShowed, value: true)
        }
        else {
            print("UISwitch FileSize state is now Off")
            setUserDefault(.fileSizeShowed, value: false)
        }
    }
    
    private lazy var changePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.gray, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = false
        button.clipsToBounds = true
        button.backgroundColor = .cyan
        button.titleLabel!.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(changePasswordButtonPressed), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    @objc func changePasswordButtonPressed() {
        //
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .lightGray
        setDefaultValues()
        view.addSubview(switchFileSorted)
        view.addSubview(switchFileSizeShowed)
        view.addSubview(switchFileSortedLabel)
        view.addSubview(switchFileSizeShowedLabel)
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            switchFileSorted.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            switchFileSorted.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            switchFileSorted.heightAnchor.constraint(equalToConstant: 50),
            switchFileSorted.widthAnchor.constraint(equalToConstant: 50),
            
            switchFileSizeShowed.topAnchor.constraint(equalTo: switchFileSorted.bottomAnchor, constant: 20),
            switchFileSizeShowed.leadingAnchor.constraint(equalTo: switchFileSorted.leadingAnchor),
            switchFileSizeShowed.heightAnchor.constraint(equalToConstant: 50),
            switchFileSizeShowed.widthAnchor.constraint(equalToConstant: 50),
            
            switchFileSortedLabel.topAnchor.constraint(equalTo: switchFileSorted.topAnchor),
            switchFileSortedLabel.leadingAnchor.constraint(equalTo: switchFileSorted.trailingAnchor, constant: 20),
            switchFileSortedLabel.heightAnchor.constraint(equalToConstant: 50),
            switchFileSortedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            switchFileSizeShowedLabel.topAnchor.constraint(equalTo: switchFileSizeShowed.topAnchor),
            switchFileSizeShowedLabel.leadingAnchor.constraint(equalTo: switchFileSizeShowed.trailingAnchor, constant: 20),
            switchFileSizeShowedLabel.heightAnchor.constraint(equalToConstant: 50),
            switchFileSizeShowedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setUserDefault(_ key: SettingType, value: Any) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    func setDefaultValues() {
        fileSorted = defaults.object(forKey: "fileSorted") as? Bool ?? true
        fileSizeShowed = defaults.object(forKey: "fileSizeShowed") as? Bool ?? true
        changePassword = defaults.object(forKey: "changePassword") as? String ?? String(decoding: KeyChain.load(key: account)!, as: UTF8.self)
    }
}
