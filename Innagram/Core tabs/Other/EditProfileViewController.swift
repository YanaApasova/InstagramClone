//
//  EditProfileViewController.swift
//  Innagram
//
//  Created by YANA on 06/11/2021.
//

import UIKit

struct EditProfileFormModel {
    let lable: String
    let placeholder:String
    var value:String?
}

final class EditProfileViewController: UIViewController,UITableViewDataSource {
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [[EditProfileFormModel]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        tableView.tableHeaderView = createTableHeaderView()
        tableView.dataSource = self
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: -TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        let model = models[indexPath.section][indexPath.row]
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else{
            return nil
        }
        return "Private information"
    }
    
    private func configureModels(){
      // name, username, bio
        let section1Lables = ["Name","Username","Bio"]
        var section1 = [EditProfileFormModel]()
        for lable in section1Lables{
            let model = EditProfileFormModel(lable: lable, placeholder: "Enter \(lable)...", value: nil)
            section1.append(model)
        }
        models.append(section1)
        
      // email, phone, gender
        
        let section2Lables = ["Email","Phone","Gender"]
        var section2 = [EditProfileFormModel]()
        for lable in section2Lables{
            let model = EditProfileFormModel(lable: lable, placeholder: "Enter \(lable)...", value: nil)
            section2.append(model)
    }
        models.append(section2)
}
    
    private func createTableHeaderView() -> UIView{ //set header and profile picture
        let header = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.width,
                                          height: view.heigth/4).integral)
        let size = header.heigth/1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width - size)/2,
                                                        y: (header.heigth - size)/2,
                                                        width: size,
                                                        height: size))
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2
        profilePhotoButton.addTarget(self, action: #selector(didTapChangePhotoPicture), for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        profilePhotoButton.tintColor = .label
        return header
    }
    
    @objc private func didTapChangePhotoPicture(){
        
    }
    
    
    
    @objc private func didTapSave(){
        // save onfo to database
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapCancel(){
      dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapChangeProfilePicture(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change Profile Picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take photo",
                              style:.default, handler: { _ in
            
        }));
        actionSheet.addAction(UIAlertAction(title: "Choose from Library",
                            style:.default, handler: { _ in
                                                
        }));
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                              style:.default))
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        present(actionSheet, animated: true)
    }
}
extension EditProfileViewController:FormTableViewCellDelegate{
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
       
        
        
    }

}
