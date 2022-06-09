//
//  ProfileTabsCollectionReusableView.swift
//  Innagram
//
//  Created by YANA on 17/11/2021.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
     static let identifier = "ProfileTabsCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
