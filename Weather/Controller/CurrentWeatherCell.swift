//
//  CurrentWeatherCell.swift
//  Weather
//
//  Created by Дарья Носова on 04.05.2022.
//

import Foundation
import UIKit

class CurrentWeatherCell: UICollectionViewCell {
    static var reuseId: String = "CurrentWeatherCell"
    
    let temperature = UILabel()
    
    let weatherIcon = UIImageView()
    let weatherDescription = UILabel()
    let feelsLike = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 1, alpha: 1)
        
        customizeElements()
        setupConstraints()
    }
    
    func configure(with modelWeather: ModelWeather) {
        let weather = modelWeather.current
        temperature.text = "\(getTemperature(temperature: weather.temp))"
        weatherIcon.image = UIImage(named: weather.weather[0].icon)
        weatherDescription.text = weather.weather[0].description?.capitalized ?? ""
        feelsLike.text = "Ощущается как \(getTemperature(temperature: weather.feels_like))"
    }
    
    func customizeElements() {
        temperature.textColor = .black
        temperature.font = UIFont(name: "avenir", size: 40)
        temperature.translatesAutoresizingMaskIntoConstraints = false
        
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        
        weatherDescription.textColor = .black
        weatherDescription.font = UIFont(name: "avenir", size: 16)
        weatherDescription.translatesAutoresizingMaskIntoConstraints = false
        
        feelsLike.textColor = .black
        feelsLike.font = UIFont(name: "avenir", size: 16)
        feelsLike.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Setup Constraints

extension CurrentWeatherCell {
    func setupConstraints() {
        addSubview(temperature)
        addSubview(weatherIcon)
        addSubview(weatherDescription)
        addSubview(feelsLike)
        
        // temperature constraints
        temperature.widthAnchor.constraint(equalToConstant: 88).isActive = true
        temperature.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        // weatherIcon constraints
        weatherIcon.widthAnchor.constraint(equalToConstant: 80).isActive = true
        weatherIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        // Stack View
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalCentering
        stackView.alignment = UIStackView.Alignment.center
        
        stackView.addArrangedSubview(temperature)
        stackView.addArrangedSubview(weatherIcon)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        
        // Stack View constraints
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 168).isActive = true
//        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
//
//        // weatherDiscription constraints
        weatherDescription.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0).isActive = true
//        weatherDescription.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        weatherDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//
//
//        // feelsLike constraints
        feelsLike.topAnchor.constraint(equalTo: weatherDescription.bottomAnchor, constant: 8).isActive = true
        feelsLike.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func getTemperature(temperature: Double) -> String {
        var temperatureWithSigns = ""
        
        if temperature > 0 {
            temperatureWithSigns = "+\(Int(round((temperature * 10)/10)))°"
        } else {
            temperatureWithSigns = "\(Int(round((temperature * 10)/10)))°"
        }
        
        return temperatureWithSigns
    }
}
