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
        
        customizeElements()
        setupConstraints()

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
    
    func configure(with weather: ModelWeather) {
        let ourWeather = weather.hourly
        temperature.text = "+\(Int(round((ourWeather[0].temp * 10) / 10)))\u{00B0}"
        time.text = getTime(timestamp: NSNumber(value: ourWeather[0].dt))
        weatherImage.image = UIImage(named: ourWeather[0].weather[0].icon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HourlyWeatherCell {
    
    func customizeElements() {
        
        time.font = UIFont(name: "avenir", size: 15)
        time.textColor = .black
        time.backgroundColor = .yellow
        
        temperature.font = UIFont(name: "avenir", size: 15)
        temperature.textColor = .black
        temperature.backgroundColor = .blue
        
        weatherImage.layer.borderColor = UIColor.black.cgColor
        weatherImage.layer.borderWidth = 0.5
        weatherImage.layer.cornerRadius = 5.0
        
        weatherImage.layer.shadowColor = UIColor.black.cgColor
        weatherImage.layer.shadowOffset = CGSize(width: 4, height: 4)
        weatherImage.layer.shadowOpacity = 0.2
        weatherImage.layer.shadowRadius = 5.0

    }
    
    func setupConstraints() {
        
        addSubview(weatherImage)
        addSubview(temperature)
        addSubview(time)
        
        // time constraints
        time.translatesAutoresizingMaskIntoConstraints = false
        time.widthAnchor.constraint(equalToConstant: 50).isActive = true
        time.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // weatherImage constraints
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // temperature constraints
        temperature.translatesAutoresizingMaskIntoConstraints = false
        temperature.widthAnchor.constraint(equalToConstant: 60).isActive = true
        temperature.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let stackView = UIStackView()
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(time)
        stackView.addArrangedSubview(weatherImage)
        stackView.addArrangedSubview(temperature)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing

        
        //stackView constraints
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        stackView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 70).isActive = true
                
    }
}
