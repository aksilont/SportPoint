//
//  DetailInfoView.swift
//  SportPoint
//
//  Created by Aksilont on 11.03.2023.
//

import UIKit

protocol DetailInfoDelegate: AnyObject {
    func closeDetailView()
    func openWebsite(_ url: String)
    func order(_ point: Point)
}

class DetailInfoView: UIView {

    // MARK: - IBOutlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var walktimeLabel: UILabel!
    @IBOutlet weak var worktimeLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var webButton: UIButton!
    @IBOutlet weak var orderButton: UIButton!
    
    // MARK: - Private Properties
    
    private var point: Point?
    
    // MARK: - Public Properties
    
    var delegate: DetailInfoDelegate?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: Self.self), owner: self)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    // MARK: - Lyfe Cycle
    
    override func layoutSubviews() {
        orderButton.corneredRadius(radius: orderButton.bounds.height / 2)
        contentView.corneredRadius(radius: 30, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    
    // MARK: - Methods
    
    func configureView(point: Point) {
        self.point = point
        nameLabel.text = point.name
        adressLabel.text = point.adress
        descriptionTextView.text = point.description
        worktimeLabel.text = point.workTime
        walktimeLabel.text = "--- min"
        phoneLabel.text = point.phone
        webButton.setTitle(point.webSite, for: .normal)
    }
    
    // MARK: - IBActions
    
    @IBAction func closeDidTap(_ sender: UIButton) {
        delegate?.closeDetailView()
    }
    
    @IBAction func webDidTap(_ sender: UIButton) {
        guard let urlString = point?.webSite else { return }
        delegate?.openWebsite(urlString)
    }
    
    @IBAction func orderDidTap(_ sender: UIButton) {
        guard let point else { return }
        delegate?.order(point)
    }
    
}
