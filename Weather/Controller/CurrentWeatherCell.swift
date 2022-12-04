//
//  CurrentWeatherCell.swift
//  Weather
//
//  Created by Дарья Носова on 04.05.2022.
//

import SnapKit
import UIKit

class CurrentWeatherCell: UICollectionViewCell {
    static var reuseId: String = "CurrentWeatherCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 1, alpha: 1)
    }
    
    func configure(with modelWeather: ModelWeather) {
        
        let weather = modelWeather.current
        
        let temperature = UILabel()
        temperature.text = "\(getTemperature(temperature: weather.temp))"
        temperature.textColor = .black
        temperature.font = UIFont(name: "avenir", size: 40)
        temperature.translatesAutoresizingMaskIntoConstraints = false
        addSubview(temperature)
        
        temperature.snp.makeConstraints { maker in
            maker.width.equalTo(88)
            maker.height.equalTo(88)
        }
        
        let weatherIcon = UIImageView()
        weatherIcon.image = UIImage(named: weather.weather[0].icon)
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weatherIcon)
        
        weatherIcon.snp.makeConstraints { maker in
            maker.width.equalTo(88)
            maker.width.equalTo(88)
        }
        
        let stackView = UIStackView()
        stackView.layer.shadowColor = UIColor.black.cgColor
        stackView.layer.shadowOffset = CGSize(width: 5, height: 5)
        stackView.layer.shadowOpacity = 0.2
        stackView.layer.shadowRadius = 2.0
        
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalCentering
        stackView.alignment = UIStackView.Alignment.center
        
        stackView.addArrangedSubview(temperature)
        stackView.addArrangedSubview(weatherIcon)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        stackView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.top.equalToSuperview().inset(10)
            maker.width.equalTo(168)
        }
        
        let weatherDescription = UILabel()
        weatherDescription.text = weather.weather[0].description ?? ""
        weatherDescription.textColor = .black
        weatherDescription.font = UIFont(name: "avenir", size: 16)
        weatherDescription.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weatherDescription)
        
        weatherDescription.snp.makeConstraints { maker in
            maker.top.equalTo(stackView).inset(150)
            maker.centerX.equalToSuperview()
        }
        
        let feelsLike = UILabel()
        feelsLike.text = "Ощущается как \(getTemperature(temperature: weather.feels_like))"
        feelsLike.textColor = .black
        feelsLike.font = UIFont(name: "avenir", size: 16)
        feelsLike.translatesAutoresizingMaskIntoConstraints = false
        addSubview(feelsLike)
        
        feelsLike.snp.makeConstraints { maker in
            maker.top.equalTo(weatherDescription).inset(40)
            maker.centerX.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrentWeatherCell {
    
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
