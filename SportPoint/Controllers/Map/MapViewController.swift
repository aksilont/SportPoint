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
    private var filteredDataPoints: [Point] = [] {
        didSet {
            mapService.setupPoints(points: filteredDataPoints)
        }
    }
    
    private var mapService: AppleMapService!
    
    private lazy var calloutView: ShortInfoView = ShortInfoView()
    
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
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        mapView.addGestureRecognizer(gesture)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        leftView.tintColor = .systemGray
        
        let rightView = UIButton()
        rightView.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        rightView.tintColor = .systemGray
        rightView.addTarget(self, action: #selector(clearButtonDidTap), for: .touchUpInside)
        
        searchTextField.delegate = self
        
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
        
        calloutView.delegate = self
        view.addSubview(calloutView)
    }
    
    private func fetchData() {
        DataService.fectData { [weak self] result in
            switch result {
            case .success(let points):
                self?.dataPoints = points
            case .failure(let error):
                self?.showAlert(title: "Ошибка", message: error.localizedDescription)
            }
        }
    }
    
    @objc private func clearButtonDidTap(_ sender: UIButton) {
        searchTextField.text = ""
        filteredDataPoints = dataPoints
    }
    
    @objc private func viewDidTap(_ sender: UITapGestureRecognizer) {
        searchTextField.endEditing(true)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select item")
        let typeOfSport = typesOfSportPoint[indexPath.row]
        filteredDataPoints = dataPoints.filter {
            $0.type.rawValue == typeOfSport
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselect item")
        filteredDataPoints = dataPoints
    }
    
}

// MARK: - UICollectionViewDelegate

extension MapViewController: UICollectionViewDelegate {}

// MARK: - MapServiceDelegate

extension MapViewController: MapServiceDelegate {
    func showAlertMapService(title: String, message: String) {
        showAlert(title: title, message: message)
    }
    
    func showCalloutView(point: Point) {
        let inset = 15.0
        let height = view.bounds.height / 2
        let width = view.bounds.width - 2 * inset
        let xPosition = inset
        let yPosition = view.bounds.height - height
        calloutView.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        calloutView.configureView(point: point)
        calloutView.alpha = 0
        calloutView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.calloutView.alpha = 1
        }
    }
    
    func hideCalloudView() {
        calloutView.alpha = 0
        calloutView.isHidden = true
    }
}

// MARK: - UITextFieldDelegate

extension MapViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if updatedText.count < 2 { filteredDataPoints = dataPoints }
            else {
                filteredDataPoints = dataPoints.filter {
                    $0.name.uppercased().contains(updatedText.uppercased())
                }
            }
        }
        return true
    }
}

// MARK: - ShortInfoDelegate

extension MapViewController: ShortInfoDelegate {
    func routTo(_ point: Point) {
        print("Making route....")
    }
    
    func detailInfo(_ point: Point) {
        print("Go to detail...")
    }
}
