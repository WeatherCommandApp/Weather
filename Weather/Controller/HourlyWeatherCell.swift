//
//  HourlyWeatherCell.swift
//  Weather
//
//  Created by admin on 04.05.2022.
//
import SnapKit
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
    
    func customizeElements() {
        time.font = UIFont(name: "avenir", size: 15)
        time.textColor = .black
        time.textAlignment = .center
        
        temperature.font = UIFont(name: "avenir", size: 15)
        temperature.textColor = .black
        temperature.textAlignment = .center
    }
    
    func configure(with weather: ModelWeather) {
        let weather = weather.hourly
        temperature.text = "\(getTemperature(temperature: weather[0].temp))\u{00B0}"
        time.text = getTime(timestamp: NSNumber(value: weather[0].dt))
        weatherImage.image = UIImage(named: weather[0].weather[0].icon)
    }
    
    func setupConstraints() {
        let stackView = UIStackView()
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(time)
        stackView.addArrangedSubview(weatherImage)
        stackView.addArrangedSubview(temperature)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        
        //stackView setups
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        //stackView's layer setups
        stackView.layer.shadowColor = UIColor.black.cgColor
        stackView.layer.shadowOffset = CGSize(width: 5, height: 5)
        stackView.layer.shadowOpacity = 0.2
        stackView.layer.shadowRadius = 2.0

        //stackView constraints
        stackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        //weatherImage constraints
        weatherImage.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }


    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HourlyWeatherCell {
    func getTime(timestamp: NSNumber) -> String {
        
        let date  = Date(timeIntervalSince1970: TimeInterval(truncating: timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: date)
        return time
    }
    
    func getTemperature(temperature: Double) -> String {
        var temperatureWithSigns = ""
        
        if temperature > 0 {
            temperatureWithSigns = "+\(Int(round((temperature * 10)/10)))"
        } else {
            temperatureWithSigns = "\(Int(round((temperature * 10)/10)))"
        }
        
        return temperatureWithSigns
    }
}
