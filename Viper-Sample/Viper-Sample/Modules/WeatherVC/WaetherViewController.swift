//
//  WaetherViewController.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//
//

import UIKit
final class WaetherViewController: UIViewController {
    // MARK: - Public properties -

    var presenter: WaetherPresenterInterface!
    private let cellID = "cellID"

    @IBOutlet var currentTemp: UILabel!
    @IBOutlet var currentDespriction: UILabel!
    @IBOutlet var locationName: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var cloudLbl: UILabel!
    @IBOutlet var currentDate: UILabel!
    @IBOutlet var windLbl: UILabel!
    @IBOutlet var humudityLbl: UILabel!
    @IBOutlet var sunriseLbl: UILabel!
    @IBOutlet var sunsetLbl: UILabel!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        presenter.requestApi(39.92, longLat: 32.86)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellWithReuseIdentifier: cellID)
    }
}

// MARK: - Extensions -

extension WaetherViewController: WaetherViewInterface {
    func reloadList(_ model: WeatherModel?) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.collectionView.reloadData()

            if let current = model?.current {
                self.windLbl.text = "\(String(current.windSpeed ?? 0)) km"
                if let humidity = current.humidity {
                    self.humudityLbl.text = "%\(humidity)"
                }
                if let sunset = current.sunset {
                    self.sunsetLbl.unixTimestampToDate(dt: sunset, type: .hours)
                }
                if let sunrise = current.sunrise {
                    self.sunriseLbl.unixTimestampToDate(dt: sunrise, type: .hours)
                }
                if let currenDate = current.dt {
                    self.currentDate.unixTimestampToDate(dt: currenDate, type: .fullDate)
                }
                if let could = current.clouds {
                    self.cloudLbl.text = "%\(could)"
                }
                if let desp = current.weather?.first?.description {
                    self.currentDespriction.text = desp.capitalized
                }
                if let temp = current.temp {
                    self.currentTemp.text = String(format: "%d℃", Int(temp))
                }
            }

            if let lon = model?.lon, let lat = model?.lat {
                locationName.getCurrentPlace(latitude: lat, longitude: lon)
            }
        }
    }

    func isLoading() {}

    func stopLoading() {}
}

extension WaetherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! WeatherCell
        if let item = presenter.item(at: indexPath) {
            cell.setupUI(item: item)
        }

        return cell
    }

    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 7
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let h = collectionView.frame.height
        let w = h * 9 / 14
        return CGSize(width: w, height: h)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 4
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }
}
