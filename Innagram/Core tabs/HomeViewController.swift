//
//  ViewController.swift
//  Innagram
//
//  Created by YANA on 06/11/2021.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    private let tableView:UITableView = {
       let tableView = UITableView()
        tableView.register(IGPostTableViewCell.self, forCellReuseIdentifier: IGPostTableViewCell.identifier)
        
        
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
        }
    
     
    private func handleNotAuthenticated(){
        //chek user status
        if Auth.auth().currentUser == nil {
            //show login
            let loginVc = LoginViewController()
            loginVc.modalPresentationStyle = .fullScreen
            present(loginVc,animated: false)
        }
    }
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IGPostTableViewCell.identifier, for: indexPath) as! IGPostTableViewCell
        return cell
    }
}
