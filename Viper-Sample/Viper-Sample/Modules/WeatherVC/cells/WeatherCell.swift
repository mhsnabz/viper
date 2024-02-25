//
//  WeatherCell.swift
//  Viper-Sample
//
//  Created by srbrt on 24.02.2024.
//

import UIKit
class WeatherCell: UICollectionViewCell {
    @IBOutlet var datLbl: UILabel!
    @IBOutlet var degreeLbl: UILabel!
    @IBOutlet var iconView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI(item: Daily, metricType: MetricType) {
        if let currentDay = item.dt {
            datLbl.unixTimestampToDate(dt: currentDay)
        }

        if let value = item.temp?.day {
            degreeLbl.text = String(format: metricType == .celcuis ? "%d℃" : "%d℉", Int(value))
        }

        if let icon = item.weather?.first?.icon {
            iconView.loadIcon(iconId: icon)
        }
    }

    func setupUI(item: Hourly, metricType: MetricType) {
        if let currentDay = item.dt {
            datLbl.unixTimestampToDate(dt: currentDay, type: .hours)
        }

        if let value = item.temp {
            degreeLbl.text = String(format: metricType == .celcuis ? "%d℃" : "%d℉", Int(value))
        }

        if let icon = item.weather?.first?.icon {
            iconView.loadIcon(iconId: icon)
        }
    }
}
