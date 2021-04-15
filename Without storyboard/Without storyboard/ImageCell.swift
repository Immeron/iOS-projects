//
//  ImageCell.swift
//  Without storyboard
//
//  Created by Илья Виноградов on 15.04.2021.
//

import UIKit

class ImageCell: UITableViewCell {

    var imageViewInCell = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(imageViewInCell)
        addImageViewConstraints()
        imageViewInCell.layer.masksToBounds = true
        imageViewInCell.layer.cornerRadius = 10
        imageViewInCell.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addImageViewConstraints() {
        
        imageViewInCell.translatesAutoresizingMaskIntoConstraints = false
        imageViewInCell.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        imageViewInCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        imageViewInCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        imageViewInCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true


        
        
    }

}
