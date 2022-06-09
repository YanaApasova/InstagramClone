//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Innagram
//
//  Created by YANA on 17/11/2021.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject{
    func profileHeaderDidTapPostsButton(_header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfile(_header: ProfileInfoHeaderCollectionReusableView)
}

 final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
     static let identifier = "ProfileInfoHeaderCollectionReusableView"
     
     public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
      
    private let profilePhotoImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postsButton:UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followersButton:UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followingButton:UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let editProfileButton:UIButton = {
        let button = UIButton()
        button.setTitle("Edit your profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Yana Apasova"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let bioLabel:UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text  = "This is the first account"
        label.numberOfLines = 0 //line wrap
        return label
    }()
    // MARK: -Init
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(x: 5,
                                             y: 5,
                                             width: profilePhotoSize,
                                             height: profilePhotoSize).integral
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width - 10 - profilePhotoSize)/3
        
        postsButton.frame = CGRect(x: profilePhotoImageView.right,
                                   y: 5,
                                   width: countButtonWidth,
                                   height: buttonHeight).integral
      followersButton.frame = CGRect(x: postsButton.right,
                                   y: 5,
                                   width: countButtonWidth,
                                   height: buttonHeight).integral
        followingButton.frame = CGRect(x: followersButton.right,
                                   y: 5,
                                   width: countButtonWidth,
                                   height: buttonHeight).integral
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right,
                                         y: 5+buttonHeight,
                                         width: countButtonWidth+3,
                                         height: buttonHeight).integral
        nameLabel.frame = CGRect(x: 5,
                                 y: 5+profilePhotoImageView.bottom,
                                 width: width - 10,
                                 height: 15).integral
        let bioLableSize = bioLabel.sizeThatFits(self.frame.size)
        bioLabel.frame = CGRect(x: 5,
                                y: 5 + nameLabel.bottom,
                                width: width - 10,
                                height: bioLableSize.height).integral
    }
    
    private func addSubviews(){
        addSubview(bioLabel)
        addSubview(profilePhotoImageView)
        addSubview(postsButton)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
    }
}
