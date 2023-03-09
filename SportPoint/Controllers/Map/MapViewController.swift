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
    @IBOutlet weak var searchTextField: CustomTextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private Properties
    
    private let typesOfSportPoint = TypeOfSportPoint.allCases.map { $0.rawValue }
    
    private var dataPoints: [Point] = [] {
        didSet { filteredDataPoints = dataPoints }
    }
    private var filteredDataPoints: [Point] = []
    
    private var mapService: AppleMapService!
    
    // MARK: - Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        setupView()
        fetchData()
    }
    
    // MARK: - Private Methods
    
    private func configureMap() {
        mapView.showsUserLocation = true
        mapService = AppleMapService(mapView: mapView)
        mapService.delegate = self
    }
    
    private func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        leftView.tintColor = .systemGray
        
        let rightView = UIButton()
        rightView.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        rightView.tintColor = .systemGray
        
        searchTextField.leftView = leftView
        searchTextField.leftViewMode = .always
        
        searchTextField.rightView = rightView
        searchTextField.rightViewMode = .always
        
        searchTextField.borderStyle = .none
        searchTextField.backgroundColor = .white
        searchTextField.keyboardType = .default
        searchTextField.autocapitalizationType = .none
        searchTextField.autocorrectionType = .no
        searchTextField.spellCheckingType = .no
        searchTextField.returnKeyType = .done
        
        searchTextField.corneredRadius(radius: 20)
        searchTextField.addShadow(color: .black,
                                  radius: 6,
                                  offset: CGSize(width: 0, height: 3))
    }
    
    private func fetchData() {
        DataService.fectData { [weak self] result in
            switch result {
            case .success(let points):
                self?.dataPoints = points
                self?.mapService.setupPoints(points: points)
            case .failure(let error):
                self?.showAlert(title: "Ошибка", message: error.localizedDescription)
            }
        }
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

// MARK: - MapServiceDelegate

extension MapViewController: MapServiceDelegate {
    func showAlertMapService(title: String, message: String) {
        showAlert(title: title, message: message)
    }
}
