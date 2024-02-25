//
//  AdressCell.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//

import UIKit

class AdressCell: UITableViewCell {
    @IBOutlet var adress: UILabel!
    @IBOutlet var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func setupUI(model: SearchLocationModel) {
        if let name = model.name {
            self.name.text = name
        }

        if let addres = model.displayName {
            adress.text = addres
        }
    }
}
