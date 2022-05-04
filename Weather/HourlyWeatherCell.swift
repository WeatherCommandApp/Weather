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
        
        setupElements()
        setupConstraints()
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        
    }
    
    func getDay(value: Int) -> String {
            switch value {
            case 1:
                return "Sunday"
            case 2:
                return "Monday"
            case 3:
                return "Tuesday"
            case 4:
                return "Wednesday"
            case 5:
                return "Thursday"
            case 6:
                return "Friday"
            case 7:
                return "Saturday"
            default:
                return ""
            }
        }
    
    func getDateDayAndTime(timestamp: NSNumber) -> String {
            let date  = Date(timeIntervalSince1970: Double(truncating: timestamp)/1000)
            let calendar = Calendar.current
     
            if calendar.isDateInToday(date) {
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = NSTimeZone.local
                dateFormatter.dateFormat = "hh:mm a"
                let time = dateFormatter.string(from: date)
                return time
            }else if calendar.isDateInYesterday(date) {
                return "Yesterday"
            }
            else if calendar.isDateInWeekend(date) {
                let component = calendar.component(Calendar.Component.weekday, from: date)
                return self.getDay(value: component)
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = NSTimeZone.local
                dateFormatter.dateFormat = "dd/MM/YY"
                let time = dateFormatter.string(from: date)
                return time
            }
        }

    func setupElements() {
        
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        temperature.translatesAutoresizingMaskIntoConstraints = false
        time.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func configure(with weather: Weather, and description: WeatherDescription) {
        temperature.text = String(weather.temp)
        time.text = getDateDayAndTime(timestamp: NSNumber(value: weather.dt))
        weatherImage.image = UIImage(named: description.icon)
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
