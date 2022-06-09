//
//  IGPostTableViewCell.swift
//  Innagram
//
//  Created by YANA on 14/11/2021.
//

import UIKit

final class IGPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGPostTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(){
}
}
