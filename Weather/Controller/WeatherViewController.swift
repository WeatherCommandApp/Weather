//
//  ViewController.swift
//  Weather
//
//  Created by Дарья Носова on 28.04.2022.
//

import UIKit

let data = Bundle.main.decode(ModelWeather.self, from: "weather.json")

class WeatherViewController: UIViewController {
    
    let sections: [ModelItem] = [
        ModelItem(
            data: ModelWeather(id: UUID(), current: data.current, hourly: data.hourly, daily: data.daily),
            type: ModelType.currentWeather
        ),
        ModelItem(
            data: ModelWeather(id: UUID(), current: data.current, hourly: data.hourly, daily: data.daily),
            type: ModelType.dailyWeather
        )
    ]
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<ModelItem, ModelWeather>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        setupCollectionView()
        createDataSource()
        reloadData()
        
    }
    
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.register(CurrentWeatherCell.self, forCellWithReuseIdentifier: CurrentWeatherCell.reuseId)
        collectionView.register(DailyWeatherCell.self, forCellWithReuseIdentifier: DailyWeatherCell.reuseId)
    }
    
    // MARK: - Manage the data in UICV
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ModelItem, ModelWeather>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, modelWeather) -> UICollectionViewCell? in
            
            switch self.sections[indexPath.section].type {
                case .currentWeather:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCell.reuseId, for: indexPath) as? CurrentWeatherCell
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
        }

        dataSource?.applySnapshotUsingReloadData(snapshot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.sections[sectionIndex]
            switch section.type {
                case .currentWeather:
                    return self.createCurrentWeatherSection()
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
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 30, trailing: 0)
        
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
