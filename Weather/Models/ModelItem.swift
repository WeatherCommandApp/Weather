//
//  ModelItem.swift
//  Weather
//
//  Created by Дарья Носова on 05.05.2022.
//

import Foundation

enum ModelType {
    case currentWeather
    
}

struct ModelItem: Hashable {
    let data: ModelWeather
    let type: ModelType
}

