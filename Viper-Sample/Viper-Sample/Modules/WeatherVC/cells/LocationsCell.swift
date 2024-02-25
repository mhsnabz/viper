//
//  LocationsCell.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//

import UIKit

class LocationsCell: UICollectionViewCell {
    @IBOutlet var locationName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override var isSelected: Bool {
        didSet {
            locationName.textColor = isSelected ? .white : UIColor(white: 1, alpha: 0.4)
            locationName.layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor(white: 1, alpha: 0.4).cgColor
        }
    }

    func setupUI(_ item: Locations) {
        if let name = item.locationName {
            locationName.text = name
        }
    }
}
