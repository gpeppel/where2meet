//
//  CustomCell.swift
//  where2meet
//
//  Created by Gregory peppel on 11/13/21.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var isClosedLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var isClosed: Bool = false {
        didSet {
            if isClosed {
                isClosedLabel.text = "CLOSED"
                isClosedLabel.textColor = UIColor(red: 148 / 255, green: 33 / 255, blue: 147 / 255, alpha: 1)
            } else {
                isClosedLabel.text = "OPEN NOW"
                isClosedLabel.textColor = UIColor(red: 194 / 255, green: 213 / 255, blue: 62 / 255, alpha: 1)
            }
        }
    }
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
//            parentView.layer.cornerRadius = 25
        
    }
}
