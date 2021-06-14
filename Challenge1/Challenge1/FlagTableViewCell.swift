//
//  FlagTableViewCell.swift
//  Challenge1
//
//  Created by Carlos Barcelos on 07/06/21.
//

import UIKit

class FlagTableViewCell: UITableViewCell {

    @IBOutlet weak var flagImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        flagImageView.layer.borderWidth = 1.5
        flagImageView.layer.borderColor = UIColor.lightGray.cgColor
    }

}
