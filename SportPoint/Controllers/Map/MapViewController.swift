//
//  MapViewController.swift
//  SportPoint
//
//  Created by Aksilont on 08.03.2023.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private Properties
    
    private let typesOfSportPoint = TypeOfSportPoint.allCases.map { $0.rawValue }
    
    // MARK: - Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        setupView()
    }
    
    // MARK: - Private Methods
    
    private func configureMap() {
        mapView.showsUserLocation = true
    }
    
    private func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

// MARK: - UICollectionViewDataSource

extension MapViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typesOfSportPoint.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "TypePointCell",
            for: indexPath) as? TypePointCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configure(title: typesOfSportPoint[indexPath.row])
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension MapViewController: UICollectionViewDelegate {}
