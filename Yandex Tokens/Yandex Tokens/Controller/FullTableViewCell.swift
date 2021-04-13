//
//  FullTableViewCell.swift
//  Yandex Tokens
//
//  Created by Илья Виноградов on 28.03.2021.
//

import UIKit

class FullTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        logoImage.layer.cornerRadius = logoImage.frame.size.width / 2
        logoImage.clipsToBounds = true
        logoImage.contentMode = .scaleAspectFit
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        logoImage.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
