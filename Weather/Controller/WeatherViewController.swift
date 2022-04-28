//
//  ViewController.swift
//  Weather
//
//  Created by Дарья Носова on 28.04.2022.
//

import UIKit

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
    }


}








// MARK: - SwiftUI

import SwiftUI
struct WeatherProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let weatherVC = WeatherViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<WeatherProvider.ContainerView>) ->
        WeatherViewController {
            return weatherVC
        }
        
        func updateUIViewController(_ uiViewController: WeatherProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<WeatherProvider.ContainerView>) {
            
        }
    }
}
