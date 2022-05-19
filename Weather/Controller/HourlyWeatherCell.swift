//
//  HourlyWeatherCell.swift
//  Weather
//
//  Created by admin on 04.05.2022.
//
import Foundation
import UIKit

class HourlyWeatherCell: UICollectionViewCell {
    
    static var reuseId: String = "HourlyWeatherCell"
    
    let weatherImage = UIImageView()
    let temperature = UILabel()
    let time = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 1, alpha: 1)
        
        setupConstraints()
        setupElements()

        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        
    }

    func getTime(timestamp: NSNumber) -> String {
        
        let date  = Date(timeIntervalSince1970: TimeInterval(truncating: timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: date)
        return time
    }


    func setupElements() {
        
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        temperature.translatesAutoresizingMaskIntoConstraints = false
        time.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func configure(with weather: ModelWeather) {
        let ourWeather = weather.hourly
        temperature.text = String(ourWeather[0].temp)
        time.text = getTime(timestamp: NSNumber(value: ourWeather[0].dt))
        weatherImage.image = UIImage(named: ourWeather[0].weather[0].icon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HourlyWeatherCell {
    
    func setupConstraints() {
        addSubview(weatherImage)
        addSubview(temperature)
        addSubview(time)
        
        //time constraints
        time.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        time.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        time.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        time.bottomAnchor.constraint(equalTo: weatherImage.topAnchor).isActive = true
        //weatherImage constraints
        weatherImage.topAnchor.constraint(equalTo: time.bottomAnchor).isActive = true
        weatherImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        weatherImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        weatherImage.bottomAnchor.constraint(equalTo: temperature.topAnchor).isActive = true
        
        //temperature constraints
        temperature.topAnchor.constraint(equalTo: weatherImage.bottomAnchor).isActive = true
        temperature.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        temperature.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        temperature.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
