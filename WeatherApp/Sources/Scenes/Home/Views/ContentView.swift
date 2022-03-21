//
//  ContentView.swift
//  WeatherApp
//
//  Created by Josué on 21/03/22.
//

import SnapKit
import UIKit

enum ContentViewState {
    case loading
    case data(
        cityName: String,
        temperature: String,
        maxTemperature: String,
        minTemperature: String,
        weather: String
    )
    case error
}

protocol ContentViewProvider {
    var weatherIcon: UIImageView { get }

    func setState(_ state: ContentViewState)
}

final class ContentView: UIView, ContentViewProvider {

    // MARK: - View components

    private lazy var container: UIStackView = {
        let containerStackView = UIStackView()
        containerStackView.axis = .vertical

        let stackViewHFirstLine = UIStackView()
        stackViewHFirstLine.axis = .horizontal
        stackViewHFirstLine.addArrangedSubview(weatherIcon)
        stackViewHFirstLine.addArrangedSubview(temperature)
        stackViewHFirstLine.spacing = 8
        stackViewHFirstLine.alignment = .center

        containerStackView.addArrangedSubview(stackViewHFirstLine)
        containerStackView.addArrangedSubview(weatherDescription)

        let stackViewHLasttLine = UIStackView()
        stackViewHLasttLine.axis = .horizontal
        stackViewHLasttLine.addArrangedSubview(minTemperature)
        stackViewHLasttLine.addArrangedSubview(maxTemperature)

        containerStackView.addArrangedSubview(stackViewHLasttLine)

        return containerStackView
    }()

    let weatherIcon: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()

    private let loading: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .gray
        return activityIndicator
    }()

    private let cityName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 36)
        return label
    }()

    private let temperature: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 48)
        return label
    }()

    private let weatherDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()

    private let maxTemperature: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()

    private let minTemperature: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Unable to load data"
        label.font = .systemFont(ofSize: 18)
        return label
    }()

    // MARK: - Initializers

    init(state: ContentViewState) {
        super.init(frame: .zero)
        setState(state)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setState(_ state: ContentViewState) {
        switch state {
        case .loading:
            errorLabel.isHidden = true
            loading.isHidden = false
            loading.startAnimating()
            cityName.isHidden = true
            container.isHidden = true
        case .data(
            let cityName,
            let temperature,
            let maxTemperature,
            let minTemperature,
            let weather
        ):
            errorLabel.isHidden = true
            loading.stopAnimating()
            loading.isHidden = true
            container.isHidden = false
            self.cityName.isHidden = false

            self.cityName.text = cityName
            self.temperature.text = temperature
            self.maxTemperature.text = maxTemperature
            self.minTemperature.text = minTemperature
            self.weatherDescription.text = weather
        case .error:
            loading.isHidden = true
            loading.startAnimating()
            cityName.isHidden = true
            container.isHidden = true
            errorLabel.isHidden = false
        }
    }

    // MARK: - Private methods

    private func addSubviews() {
        addSubview(cityName)
        addSubview(container)
        addSubview(loading)
        addSubview(errorLabel)
    }

    private func constrainSubviews() {
        weatherIcon.snp.makeConstraints { make -> Void in
            make.width.equalTo(48)
            make.height.equalTo(48)
        }
        loading.snp.makeConstraints { make -> Void in
            make.center.equalTo(self)
        }
        cityName.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.snp_topMargin)
            make.left.equalTo(self.snp_leftMargin)
        }
        container.snp.makeConstraints { make -> Void in
            make.centerX.equalTo(self.snp_centerXWithinMargins)
            make.top.equalTo(self.cityName.snp_bottomMargin).offset(48)
        }
        errorLabel.snp.makeConstraints { make -> Void in
            make.center.equalTo(self)
        }
    }

    private func setup() {
        addSubviews()
        constrainSubviews()
    }
}
