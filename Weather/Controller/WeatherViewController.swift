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
            data: data,
            type: ModelType.currentWeather
        ),
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
    }
    
    // MARK: - Manage the data in UICV
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ModelItem, ModelWeather>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, modelWeather) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCell.reuseId, for: indexPath) as? CurrentWeatherCell
            cell?.configure(with: modelWeather)
            return cell
        })
    }
    
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<ModelItem, ModelWeather>()
        snapshot.appendSections(sections)
        
        
        for section in sections {
            snapshot.appendItems([section.data], toSection: section)
        }
      
        dataSource?.apply(snapshot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            return self.createCurrentWeatherSection()
        }
        return layout
    }
    
    
    func createCurrentWeatherSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1.0/2.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
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
