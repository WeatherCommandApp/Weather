//
//  ViewController.swift
//  Weather
//
//  Created by Дарья Носова on 28.04.2022.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController {
    
    private var data: ModelWeather?
    private var sections: [ModelItem] = []
    
    private var latCoordinates: Double?
    private var lonCoordinates: Double?
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<ModelItem, ModelWeather>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        fetchUserLocation()
        setupNavigationBar()
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.register(CurrentWeatherCell.self, forCellWithReuseIdentifier: CurrentWeatherCell.reuseId)
        collectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: HourlyWeatherCell.reuseId)
        collectionView.register(DailyWeatherCell.self, forCellWithReuseIdentifier: DailyWeatherCell.reuseId)
        
    }
    
    // MARK: - Manage UICollectionView
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ModelItem, ModelWeather>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, modelWeather) -> UICollectionViewCell? in
            switch self.sections[indexPath.section].type {
            case .currentWeather:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCell.reuseId, for: indexPath) as? CurrentWeatherCell
                cell?.configure(with: modelWeather)
                return cell
            case .hourlyWeather:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.reuseId, for: indexPath) as? HourlyWeatherCell
                cell?.configure(with: modelWeather)
                return cell
            case .dailyWeather:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCell.reuseId, for: indexPath) as? DailyWeatherCell
                cell?.configure(with: modelWeather)
                return cell
            }
        })
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<ModelItem, ModelWeather>()
        snapshot.appendSections(sections)
        
        
        for section in sections {
            
            if (section.type == ModelType.currentWeather) {
                snapshot.appendItems([section.data], toSection: section)
                
            } else if (section.type == ModelType.dailyWeather) {
                for i in 0...section.data.daily.endIndex - 1 {
                    let nv = ModelWeather(id: UUID(), current: section.data.current, hourly: section.data.hourly, daily: [section.data.daily[i]])
                    snapshot.appendItems([nv], toSection: section)
                }
                
            }
            else if (section.type == ModelType.hourlyWeather) {
                for i in 0...section.data.hourly.endIndex - 1 {
                    let nv = ModelWeather(id: UUID(), current: section.data.current, hourly: [section.data.hourly[i]], daily: section.data.daily)
                    snapshot.appendItems([nv], toSection: section)
                }
            }
        }
        
        dataSource?.applySnapshotUsingReloadData(snapshot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.sections[sectionIndex]
            switch section.type {
            case .currentWeather:
                return self.createCurrentWeatherSection()
            case .hourlyWeather:
                return self.createHourlyWeatherSection()
            case .dailyWeather:
                return self.createDailyWeatherSection()
            }
        }
        return layout
    }
    
    func createCurrentWeatherSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0 / 2.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 60, trailing: 0)
        
        return section
    }
    
    func createDailyWeatherSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0 / 20.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 30, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    
    func createHourlyWeatherSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 6.0),
                                              heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 1, leading: 1, bottom: 1, trailing: 1)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.19))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 30, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    
    private func setupSections(data: ModelWeather){
        self.sections = [
            ModelItem(
                data: ModelWeather(id: UUID(), current: data.current, hourly: data.hourly, daily: data.daily),
                type: ModelType.currentWeather
            ),
            ModelItem(
                data: ModelWeather(id: UUID(), current: data.current, hourly: data.hourly, daily: data.daily),
                type: ModelType.hourlyWeather
            ),
            ModelItem(
                data: ModelWeather(id: UUID(), current: data.current, hourly: data.hourly, daily: data.daily),
                type: ModelType.dailyWeather
            )
        ]
     
    }
    
    private func fetchData(from url: String) {
        NetworkManager.shared.fetchData(from: url) { result in
            
            switch result {
            case .success(let weatherData):
                self.data = weatherData
                if let data = self.data {
                    self.setupSections(data: data)
                }
            case .failure(let error):
                self.failedAlert()
                print(error)
            }
            self.setupCollectionView()
            self.createDataSource()
            self.reloadData()
            self.collectionView.reloadData()
        }
    }
//MARK: - Location Methods
    private func fetchUserLocation() {
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else{
                    return
                }
                LocationManager.shared.resolveLocationName(with: location) { locationName in
                    strongSelf.title = locationName
                }
                
                strongSelf.latCoordinates = location.coordinate.latitude
                strongSelf.lonCoordinates = location.coordinate.longitude
                strongSelf.fetchData(from: "\(Link.weatherApi.rawValue)&lat=\(strongSelf.latCoordinates ?? 0)&lon=\(strongSelf.lonCoordinates ?? 0)")
            }
        }
    }
    
//MARK: - NavigationBar
    private func setupNavigationBar() {
        title = "Ваш город"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let navBarAppearence = UINavigationBarAppearance()
        navBarAppearence.configureWithOpaqueBackground()
        navBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        navBarAppearence.backgroundColor = UIColor(
            red: 255/255,
            green: 255/255,
            blue: 255/255,
            alpha: 227/255)
        
        navigationController?.navigationBar.standardAppearance = navBarAppearence
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearence
        
        navigationController?.navigationBar.tintColor = .white
        
    }
    // MARK: - Alert Controller
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "You can see the results in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see error in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}

// MARK: - SwiftUI Canvas
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
