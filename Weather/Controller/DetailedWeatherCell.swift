//
//  DetailedWeatherCell.swift
//  Weather
//
//  Created by admin on 30.11.2022.
//

import UIKit
import SnapKit

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
        setupConstraints()
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

extension DetailedWeatherCell {
    
    func setupConstraints() {
        addSubview(wind)
        addSubview(humidity)
        addSubview(uvi)
        addSubview(pressure)
        addSubview(visibility)
        addSubview(dewPoint)
        
        wind.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(5)
            make.top.equalTo(contentView.snp.top).offset(5)
            make.right.equalTo(humidity.snp.left).offset(-5)
        }
        
        humidity.snp.makeConstraints { make in
            make.left.equalTo(wind.snp.right).offset(5)
            make.top.equalTo(contentView.snp.top).offset(5)
            make.right.equalTo(uvi.snp.left).offset(-5)
        }
        
        uvi.snp.makeConstraints { make in
            make.left.equalTo(humidity.snp.right).offset(5)
            make.top.equalTo(contentView.snp.top).offset(5)
            make.right.equalTo(contentView.snp.right).offset(-5)
        }

        pressure.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(5)
            make.top.equalTo(wind.snp.bottom).offset(5)
            make.right.equalTo(visibility.snp.left).offset(-5)
        }
        
        visibility.snp.makeConstraints { make in
            make.left.equalTo(pressure.snp.right).offset(5)
            make.top.equalTo(humidity.snp.bottom).offset(5)
            make.right.equalTo(dewPoint.snp.left).offset(-5)
        }
        
        dewPoint.snp.makeConstraints { make in
            make.left.equalTo(visibility.snp.right).offset(5)
            make.top.equalTo(uvi.snp.bottom).offset(5)
            make.right.equalTo(contentView.snp.right).offset(-5)
        }
    }
    
}
