//
//  WaetherViewController.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//
//

import CoreLocation
import UIKit
final class WaetherViewController: UIViewController {
    // MARK: - Public properties -

    var presenter: WeatherPresenterInterface!

    private let cellID = "cellID"
    private let locationCellId = "locationCellId"

    @IBOutlet var locationCollectionView: UICollectionView!
    @IBOutlet var hoursCollectionView: UICollectionView!
    @IBOutlet var icon: UIImageView!
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
        presenter.requestApi(UserDefaults.getLatitude(), longLat: UserDefaults.getLongLatitude())
        collectionView.delegate = self
        collectionView.dataSource = self
        hoursCollectionView.dataSource = self
        hoursCollectionView.delegate = self
        locationCollectionView.dataSource = self
        locationCollectionView.delegate = self
        collectionView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        hoursCollectionView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        locationCollectionView.register(UINib(nibName: "LocationsCell", bundle: nil), forCellWithReuseIdentifier: locationCellId)
    }

    @IBAction func searchPlace(_: Any) {
        let vireFrame = SearchPlaceWireframe()
        presentWireframe(vireFrame, animated: true)
    }
}

// MARK: - Extensions -

extension WaetherViewController: WaetherViewInterface {
    func reloadList(_ model: WeatherModel?) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.collectionView.reloadData()
            self.locationCollectionView.reloadData()
            self.hoursCollectionView.reloadData()
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
                if let icon = current.weather?.first?.icon {
                    self.icon.loadIcon(iconId: icon)
                }
            }

            if let lon = model?.lon, let lat = model?.lat {
                locationName.getCurrentPlace(latitude: lat, longitude: lon)
            }

            guard let index = presenter.getLocationDataSource().firstIndex(where: { $0.latitude == UserDefaults.getLatitude() && $0.longLatitude == UserDefaults.getLongLatitude() }) else { return }
            self.locationCollectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
    }

    func isLoading() {}

    func stopLoading() {}
}

extension WaetherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == locationCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: locationCellId, for: indexPath) as! LocationsCell
            if let current = presenter.locationItem(at: indexPath) {
                cell.setupUI(current)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! WeatherCell
            if collectionView == hoursCollectionView {
                if let current = presenter.itemAtHourly(at: indexPath) {
                    cell.setupUI(item: current)
                }
            } else {
                if let item = presenter.item(at: indexPath) {
                    cell.setupUI(item: item)
                }
            }
            return cell
        }
    }

    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        if collectionView == hoursCollectionView {
            return presenter.numberOfRowInSection() > 24 ? 24 : presenter.numberOfRowInSection()
        } else if collectionView == locationCollectionView {
            return presenter.locationsNumberOfRowInSection()
        } else {
            return 7
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == locationCollectionView {
            if let currentLocation = presenter.locationItem(at: indexPath)?.locationName {
                return CGSize(width: currentLocation.width() + 20, height: locationCollectionView.frame.height)
            }
            return CGSize(width: 100, height: locationCollectionView.frame.height)
        } else {
            let w = collectionView.frame.height * 9 / 14
            return CGSize(width: w, height: 100)
        }
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 4
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }
}
