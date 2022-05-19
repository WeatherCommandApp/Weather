//
//  DailyWeatherCell.swift
//  Weather
//
//  Created by Дарья Носова on 12.05.2022.
//

import Foundation
import UIKit

class DailyWeatherCell: UICollectionViewCell {
    static var reuseId: String = "DailyWeatherCell"
    
    let date = UILabel()
    let dayOfTheWeek = UILabel()
    
    let weatherIcon = UIImageView()
    let dayTemperature = UILabel()
    let nightTemperature = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 1, alpha: 1)
        setupConstraints()
        customizeElements()
        
    }
    
    func customizeElements() {
        date.textColor = .gray
        date.font = UIFont(name: "avenir", size: 11)
        date.translatesAutoresizingMaskIntoConstraints = false
        
        dayOfTheWeek.textColor = .black
        dayOfTheWeek.font = UIFont(name: "avenir", size: 12)
        dayOfTheWeek.translatesAutoresizingMaskIntoConstraints = false
        
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        
        dayTemperature.textColor = .black
        dayTemperature.font = UIFont(name: "avenir", size: 12)
        dayTemperature.translatesAutoresizingMaskIntoConstraints = false
        
        nightTemperature.textColor = .gray
        nightTemperature.font = UIFont(name: "avenir", size: 10)
        nightTemperature.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func configure(with modelWeather: ModelWeather) {
        let weather = modelWeather.daily
        date.text = getDate(timestamp: NSNumber(value: weather[0].dt))
        dayOfTheWeek.text = getDayOfWeek(timestamp: NSNumber(value: weather[0].dt)).capitalized
        weatherIcon.image = UIImage(named: weather[0].weather[0].icon)
        dayTemperature.text = getTemperature(temperature: weather[0].temp.day)
        nightTemperature.text = getTemperature(temperature: weather[0].temp.night)
        
//        print(dayTemperature)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
}

// MARK: - Setup Constraints
extension DailyWeatherCell {
    func setupConstraints() {
        addSubview(date)
        addSubview(dayOfTheWeek)
        addSubview(weatherIcon)
        addSubview(dayTemperature)
        addSubview(nightTemperature)
        
        // date constraints
        date.widthAnchor.constraint(equalToConstant: 80).isActive = true
        date.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        // dayOfTheWeek constraints
        dayOfTheWeek.widthAnchor.constraint(equalToConstant: 80).isActive = true
        dayOfTheWeek.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // firstStackView
        let firstStackView = UIStackView()
        firstStackView.axis = NSLayoutConstraint.Axis.vertical
        firstStackView.distribution = UIStackView.Distribution.equalCentering
        firstStackView.alignment = UIStackView.Alignment.leading
        
        firstStackView.addArrangedSubview(date)
        firstStackView.addArrangedSubview(dayOfTheWeek)
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(firstStackView)
        
        
        // firstStackView constraints
        firstStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        firstStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        firstStackView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        firstStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // weatherIcon constraints
        weatherIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        weatherIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // dayTemperature constraints
        dayTemperature.widthAnchor.constraint(equalToConstant: 40).isActive = true
        dayTemperature.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // nightTemperature constraints
        nightTemperature.widthAnchor.constraint(equalToConstant:40).isActive = true
        nightTemperature.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // secondStackView
        let secondStackView = UIStackView()
        secondStackView.axis = NSLayoutConstraint.Axis.horizontal
        secondStackView.distribution = UIStackView.Distribution.equalCentering
        secondStackView.alignment = UIStackView.Alignment.center
        
        secondStackView.addArrangedSubview(weatherIcon)
        secondStackView.addArrangedSubview(dayTemperature)
        secondStackView.addArrangedSubview(nightTemperature)
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(secondStackView)
        
        // secondStackView constraints
        secondStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        secondStackView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        secondStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        secondStackView.leadingAnchor.constraint(equalTo: firstStackView.trailingAnchor, constant: 180).isActive = true
//        secondStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func getDate(timestamp: NSNumber) -> String {
        let date  = Date(timeIntervalSince1970: TimeInterval(truncating: timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: "RU_ru")
        dateFormatter.dateFormat = "d MMMM"
        let dayAndMonth = dateFormatter.string(from: date)
        return dayAndMonth
    }
    
    func getDayOfWeek(timestamp: NSNumber) -> String {
        let date = Date (timeIntervalSince1970: TimeInterval(truncating: timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: "RU_ru")
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: date)
        return dayOfWeek
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
