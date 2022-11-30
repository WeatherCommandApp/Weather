//
//  DetailedWeatherCell.swift
//  Weather
//
//  Created by admin on 30.11.2022.
//

import UIKit

class DetailedWeatherCell: UICollectionViewCell {
    
    static var reuseId: String = "DetailedWeatherCell"
    
    let wind = UILabel()
    let humidity = UILabel()
    let uvi = UILabel()
    let pressure = UILabel()
    let visibility = UILabel()
    let dewPoint = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 1, alpha: 1)
        customizeElements()
//        setupConstraints()
    }
    
    func configure(with modelWeather: ModelWeather) {
        let weather = modelWeather.current
        wind.text = "\(weather.wind_speed)"
        humidity.text = "\(weather.humidity)"
        uvi.text = "\(weather.uvi)"
        pressure.text = "\(weather.pressure)"
        visibility.text = "\(weather.visibility)"
        dewPoint.text = "\(weather.dew_point)"
    }
    
    func customizeElements() {
        
        wind.textColor = .black
        wind.font = UIFont(name: "avenir", size: 15)

        humidity.textColor = .black
        humidity.font = UIFont(name: "avenir", size: 15)

        uvi.textColor = .black
        uvi.font = UIFont(name: "avenir", size: 15)

        pressure.textColor = .black
        pressure.font = UIFont(name: "avenir", size: 15)

        visibility.textColor = .black
        visibility.font = UIFont(name: "avenir", size: 15)

        dewPoint.textColor = .black
        dewPoint.font = UIFont(name: "avenir", size: 15)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//extension DetailedWeatherCell {
//    
//    func setupConstraints() {
//        addSubview(wind)
//        addSubview(humidity)
//        addSubview(uvi)
//        addSubview(pressure)
//        addSubview(visibility)
//        addSubview(dewPoint)
//    }
//    
//}
