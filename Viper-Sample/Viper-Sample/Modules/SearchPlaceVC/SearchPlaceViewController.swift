//
//  SearchPlaceViewController.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//
//

import UIKit

final class SearchPlaceViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Public properties -

    @IBOutlet var searchTxt: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var indicatorWidth: NSLayoutConstraint!

    weak var delegate: SelectedPlaceDelegate?
    private var searchTimer: Timer?
    private let searchDelay: TimeInterval = 0.3 // 300 milliseconds
    private let cellID = "cellID"
    var presenter: SearchPlacePresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - IBActions -

    @IBAction func dismissView(_: Any) {
        dismiss(animated: true)
    }

    @IBAction func clearAction(_: Any) {
        presenter.cancelRequest()
        searchTxt.text = "" // Clear the text field
        updateClearButtonVisibility()
    }

    // MARK: - Private methods -

    private func setupUI() {
        searchTxt.setPlaceholderColor(UIColor(white: 1, alpha: 0.4))
        searchTxt.delegate = self
        searchTxt.autocorrectionType = .no
        searchTxt.autocapitalizationType = .none
        indicatorView.isHidden = true

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AdressCell", bundle: nil), forCellReuseIdentifier: cellID)
    }

    // MARK: - UITextFieldDelegate methods -

    func textField(_ textField: UITextField, shouldChangeCharactersIn _: NSRange, replacementString _: String) -> Bool {
        // Cancel the current timer if it exists
        searchTimer?.invalidate()

        // Start a new timer and call the searchPlace method after searchDelay time
        searchTimer = Timer.scheduledTimer(withTimeInterval: searchDelay, repeats: false) { [weak self] _ in
            guard let searchText = textField.text, !searchText.isEmpty else {
                return // Check for empty input and do nothing
            }
            // Send the query to the presenter
            self?.presenter.searchPlace(searchText)
            self?.updateClearButtonVisibility()
        }

        return true
    }

    func textFieldDidChangeSelection(_: UITextField) {
        updateClearButtonVisibility() // Update button visibility when text changes
    }

    // MARK: - Helper methods -

    func updateClearButtonVisibility() {
        clearButton.isHidden = searchTxt.text?.isEmpty ?? true
    }
}

// MARK: - Extensions -

extension SearchPlaceViewController: SearchPlaceViewInterface {
    // MARK: - SearchPlaceViewInterface methods -

    func updateUI() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func showIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.indicatorWidth.constant = 20
            self?.indicatorView.isHidden = false
            self?.indicatorView.startAnimating()
        }
    }

    func hideIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.indicatorView.stopAnimating()
            self?.indicatorWidth.constant = 0
            self?.indicatorView.isHidden = true
        }
    }

    func isLoading() {
        print("start animating")
    }

    func stopLoading() {
        print("stop animating")
    }
}

extension SearchPlaceViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource methods -

    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        presenter.locationsNumberOfRowInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AdressCell
        if let model = presenter.locationItem(at: indexPath) {
            cell.setupUI(model: model)
        }
        return cell
    }

    // MARK: - UITableViewDelegate methods -

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        50
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = presenter.locationItem(at: indexPath) {
            if let lat = Double(cell.lat ?? "0"), let lon = Double(cell.lon ?? "0") {
                WeatherService.shared.saveLocation(latitude: lat, longLatitude: lon, locationName: cell.name ?? "UnKnown Place")
                UserDefaults.setLatitude(lat)
                UserDefaults.setLongLatiude(lon)
                delegate?.updateView()
                dismiss(animated: true)
            }
        }
    }
}
