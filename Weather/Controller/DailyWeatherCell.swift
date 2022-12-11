//
//  DailyWeatherCell.swift
//  Weather
//
//  Created by Дарья Носова on 12.05.2022.
//

import SnapKit
import UIKit

class DailyWeatherCell: UICollectionViewCell {
    static var reuseId: String = "DailyWeatherCell"
    
    let date = UILabel()
    let dayOfTheWeek = UILabel()
    
    let weatherIcon = UIImageView()
    let dayTemperature = UILabel()
    let nightTemperature = UILabel()
    let separator = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        customizeElements()
        
    }
    
    func customizeElements() {
        date.textColor = .gray
        date.font = UIFont(name: "avenir", size: 12)
        date.translatesAutoresizingMaskIntoConstraints = false
        
        dayOfTheWeek.textColor = .black
        dayOfTheWeek.font = UIFont(name: "avenir", size: 15)
        dayOfTheWeek.translatesAutoresizingMaskIntoConstraints = false
        
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        
        dayTemperature.textColor = .black
        dayTemperature.font = UIFont(name: "avenir", size: 15)
        dayTemperature.translatesAutoresizingMaskIntoConstraints = false
        
        nightTemperature.textColor = .gray
        nightTemperature.font = UIFont(name: "avenir", size: 12)
        nightTemperature.translatesAutoresizingMaskIntoConstraints = false
        
        separator.backgroundColor = .systemGray6
    }
    
    func configure(with modelWeather: ModelWeather) {
        let weather = modelWeather.daily
        date.text = getDate(timestamp: NSNumber(value: weather[0].dt))
        dayOfTheWeek.text = getDayOfWeek(timestamp: NSNumber(value: weather[0].dt)).capitalized
        weatherIcon.image = UIImage(named: weather[0].weather[0].icon)
        dayTemperature.text = getTemperature(temperature: weather[0].temp.day)
        nightTemperature.text = getTemperature(temperature: weather[0].temp.night)
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
        addSubview(separator)
       
        
        // date constraints
        date.snp.makeConstraints { make in
            make.width.equalTo(88)
            make.height.equalTo(25)
        }
        
        
        // dayOfTheWeek constraints
        dayOfTheWeek.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(25)
        }
      
        
        // firstStackView
        let firstStackView = UIStackView()
        firstStackView.axis = NSLayoutConstraint.Axis.vertical
        firstStackView.distribution = UIStackView.Distribution.fillProportionally
        firstStackView.alignment = UIStackView.Alignment.leading
        
        firstStackView.addArrangedSubview(date)
        firstStackView.addArrangedSubview(dayOfTheWeek)
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(firstStackView)
        

        // firstStackView constraints
        firstStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        
        // weatherIcon constraints
        weatherIcon.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        
        // dayTemperature constraints
        dayTemperature.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.width.equalTo(40)
        }
        
        
        // nightTemperature constraints
        nightTemperature.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.width.equalTo(40)
        }

        
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
        secondStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(50)
            make.leading.equalTo(firstStackView).inset(250)
        }
        
        // separator constraints
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
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
