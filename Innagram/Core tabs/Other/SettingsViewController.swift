//
//  SettingsViewController.swift
//  Innagram
//
//  Created by YANA on 06/11/2021.
//

import UIKit
import SafariServices

struct SettingCellModel{
    let title:String
    let handler: (()->Void)
}

// View Controller to show user settings
final class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                   style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels(){
        data.append([SettingCellModel(title: "Edit Profile"){ [weak self] in
            self?.didTapEditProfile()
        },
            SettingCellModel(title: "Invire friends"){[weak self] in
            self?.didTapInviteFriends()
        },
            SettingCellModel(title: "Save Orginal Posts"){[weak self] in
            self?.didTapOriginalPosts()
        }
                     
    ])
        
        data.append([SettingCellModel(title: "Privacy policy"){[weak self] in
            self?.openURL(type: .privacy)
        },
        SettingCellModel(title: "Terms of service"){[weak self] in
            self?.openURL(type: .terms)
        },
        SettingCellModel(title: "Help / Feedback"){[weak self] in
            self?.openURL(type: .help)
        }
])
        
        data.append([SettingCellModel(title: "Invite friends"){
            //show share sheet to invite friends
              },
        SettingCellModel(title: "Log out"){ [weak self] in
        self?.didTapLogOut()
        }
    ])
        
}
    enum SettingsURLType{
        case terms, privacy, help
    }
    
    private  func didTapEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "Edit profile"
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: true)
    }
    private  func didTapInviteFriends(){
        
    }
    private func didTapOriginalPosts(){
        
    }
    private  func openURL(type:SettingsURLType){
        let urlString:String
        switch type{
        case .terms:urlString = "https://help.instagram.com/581066165581870"
        case .privacy:urlString = "https://help.instagram.com/196883487377501"
        case .help:urlString = "https://help.instagram.com"
        }
        
        guard let url = URL(string: urlString) else{
           return
        }
        
        let vc = SFSafariViewController(url:url)
        present(vc, animated: true)
    }
    
    
    
    
    private func didTapLogOut(){
        let actionSheet = UIAlertController(title: "Log out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { _ in
            AuthManager.shared.logOut(completion: { success in
                DispatchQueue.main.async {
                if success{
                    //present login screen
                    let loginVC = LoginViewController()
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true){
                        self.navigationController?.popToRootViewController(animated: false)
                        self.tabBarController?.selectedIndex = 0
                    }
                }
                else{
                    //trows error
                    fatalError("Could not log out user")
                }
            }
        })
        
     }))
        present(actionSheet, animated: true)
  }

}
    extension SettingsViewController: UITableViewDelegate,UITableViewDataSource {
        func numberOfSections(in tableView: UITableView)->Int{
            return data.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data[section].count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = data[indexPath.section][indexPath.row].title
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            //handle cell selection here
            let model = data[indexPath.section][indexPath.row]
            model.handler()
        }
    }
    

