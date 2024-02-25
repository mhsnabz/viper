//
//  WaetherViewController.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//
//

import CoreLocation
import UIKit
final class WaetherViewController: UIViewController, LoadingView {
    /// Lazy variable for the custom progress indicator.
    lazy var animator = CustomProgress()

    /// The presenter responsible for handling weather-related logic.
    var presenter: WeatherPresenterInterface!

    /// The selected metric type for displaying weather data (default is Celsius).
    var metricType: MetricType = .celcuis

    /// IBOutlet representing the label for the Fahrenheit unit.
    @IBOutlet var fahrenheitLbl: UILabel!

    /// Constant used for the identifiers of collection view cells.
    private let cellID = "cellID"

    /// Constant used for the identifiers of location collection view cells.
    private let locationCellId = "locationCellId"

    /// IBOutlet representing the label for the Celsius unit.
    @IBOutlet var celcuisLbl: UILabel!

    /// IBOutlet representing the background for the Fahrenheit unit.
    @IBOutlet var fahrenitBG: UIView!

    /// IBOutlet representing the background for the Celsius unit.
    @IBOutlet var celciusBG: UIView!

    /// IBOutlet representing the collection view for location items.
    @IBOutlet var locationCollectionView: UICollectionView!

    /// IBOutlet representing the collection view for hourly weather items.
    @IBOutlet var hoursCollectionView: UICollectionView!

    /// IBOutlet representing the image view for weather icon.
    @IBOutlet var icon: UIImageView!

    /// IBOutlet representing the label for current temperature.
    @IBOutlet var currentTemp: UILabel!

    /// IBOutlet representing the label for current weather description.
    @IBOutlet var currentDespriction: UILabel!

    /// IBOutlet representing the label for location name.
    @IBOutlet var locationName: UILabel!

    /// IBOutlet representing the main collection view for weather data.
    @IBOutlet var collectionView: UICollectionView!

    /// IBOutlet representing the label for cloud information.
    @IBOutlet var cloudLbl: UILabel!

    /// IBOutlet representing the label for current date.
    @IBOutlet var currentDate: UILabel!

    /// IBOutlet representing the label for wind information.
    @IBOutlet var windLbl: UILabel!

    /// IBOutlet representing the label for humidity information.
    @IBOutlet var humudityLbl: UILabel!

    /// IBOutlet representing the label for sunrise time.
    @IBOutlet var sunriseLbl: UILabel!

    /// IBOutlet representing the label for sunset time.
    @IBOutlet var sunsetLbl: UILabel!

    /// The selected index path in the location collection view.
    private var selecteIndex = IndexPath(item: 0, section: 0)

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        presenter.requestApi(UserDefaults.getLatitude(), longLat: UserDefaults.getLongLatitude(), type: metricType)
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

    private func setupMetricType(_ type: MetricType) {
        fahrenitBG.backgroundColor = type == .celcuis ? .clear : .mainYellow
        fahrenheitLbl.textColor = type == .celcuis ? UIColor(white: 1, alpha: 0.3) : .black

        celciusBG.backgroundColor = type == .celcuis ? .mainYellow : .clear
        celcuisLbl.textColor = type == .celcuis ? .black : UIColor(white: 1, alpha: 0.3)
    }

    @IBAction func celcuiusSelected(_: Any) {
        setupMetricType(.celcuis)
        metricType = .celcuis
        presenter.requestApi(UserDefaults.getLatitude(), longLat: UserDefaults.getLongLatitude(), type: metricType)
    }

    @IBAction func fahrenitSelected(_: Any) {
        setupMetricType(.fahrenit)
        metricType = .fahrenit
        presenter.requestApi(UserDefaults.getLatitude(), longLat: UserDefaults.getLongLatitude(), type: metricType)
    }

    @IBAction func searchPlace(_: Any) {
        presentSearchVC(SearchPlaceWireframe(), delegate: self)
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
                    self.currentTemp.text = String(format: metricType == .celcuis ? "%d℃" : "%d℉", Int(temp))
                }
                if let icon = current.weather?.first?.icon {
                    self.icon.loadIcon(iconId: icon)
                }
            }

            if let lon = model?.lon, let lat = model?.lat {
                locationName.getCurrentPlace(latitude: lat, longitude: lon)
            }

            self.locationCollectionView.selectItem(at: selecteIndex, animated: true, scrollPosition: .centeredHorizontally)
        }
    }

    func isLoading() {
        startLoading()
    }

    func stopLoading() {
        stop()
    }
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
                    cell.setupUI(item: current, metricType: metricType)
                }
            } else {
                if let item = presenter.item(at: indexPath) {
                    cell.setupUI(item: item, metricType: metricType)
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
                return CGSize(width: currentLocation.width() + 8, height: locationCollectionView.frame.height)
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
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == locationCollectionView {
            if let currentLocation = presenter.locationItem(at: indexPath) {
                presenter.requestApi(currentLocation.latitude, longLat: currentLocation.longLatitude, type: metricType)
                selecteIndex = indexPath
                UserDefaults.setLatitude(currentLocation.latitude)
                UserDefaults.setLongLatiude(currentLocation.longLatitude)
                locationCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                locationCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            }
        }
    }
}

extension WaetherViewController: SelectedPlaceDelegate {
    func updateView() {
        presenter.requestApi(UserDefaults.getLatitude(), longLat: UserDefaults.getLongLatitude(), type: metricType)
    }
}

enum MetricType {
    case celcuis
    case fahrenit
}
