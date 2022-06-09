//
//  FormTableViewCell.swift
//  Innagram
//
//  Created by YANA on 16/11/2021.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell,didUpdateField updatedModel:EditProfileFormModel) // protocol metods do not have bodies
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate { //custom cell class with text field and lable
    
    static let identifier = "FormTableViewCell" //identifier to use when register the cell
    private var model: EditProfileFormModel?
    
    
    
    public weak var delegate: FormTableViewCellDelegate?  //to avoid memory leak
    
    private let formLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .label
        lable.numberOfLines = 1
        return lable
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLable)
        contentView.addSubview(field)
        field.delegate = self//to get a value from field
        selectionStyle = .none //unable cell selection only text typing
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }
    
    
    public func configure(with model:EditProfileFormModel){
        self.model = model
        formLable.text = model.lable
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLable.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        //Assign frames
        formLable.frame = CGRect(x: 5,
                                 y: 0,
                                 width: contentView.width/3,
                                 height: contentView.heigth)
        field.frame = CGRect  (x: formLable.right + 5,
                                 y: 0,
                               width: contentView.width - 10 - formLable.width,
                                 height: contentView.heigth)
    }
    
    // MARK: - Textfield delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model = model else {return true}
        delegate?.formTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
}
