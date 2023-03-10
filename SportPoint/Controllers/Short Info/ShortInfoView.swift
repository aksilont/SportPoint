//
//  ShortInfoView.swift
//  SportPoint
//
//  Created by Aksilont on 10.03.2023.
//

import UIKit

protocol ShortInfoDelegate: AnyObject {
    func routTo(_ point: Point)
    func detailInfo(_ point: Point)
}

class ShortInfoView: UIView {
    
    // MARK: - IBOutlets

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var worktimeLabel: UILabel!
    @IBOutlet weak var walktimeLabel: UILabel!
    @IBOutlet weak var routeButton: UIButton!
    @IBOutlet weak var detailButton: UIButton!
    
    private var point: Point?
    
    var delegate: ShortInfoDelegate?
    
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
        mainImageView.corneredRadius(radius: 20)
        routeButton.corneredRadius(radius: routeButton.bounds.height / 2)
        contentView.corneredRadius(radius: 30, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    
    // MARK: - Methods
    
    func configureView(point: Point) {
        self.point = point
        if let namedImage = point.images?.first {
            mainImageView.image = UIImage(named: namedImage)
        }
        nameLabel.text = point.name
        adressLabel.text = point.adress
        worktimeLabel.text = point.workTime
        walktimeLabel.text = "--- min"
    }
    
    // MARK: - IBActions
    
    @IBAction func routeDidTap(_ sender: UIButton) {
        guard let point else { return }
        delegate?.routTo(point)
    }

    @IBAction func detailDidTap(_ sender: UIButton) {
        guard let point else { return }
        delegate?.detailInfo(point)
    }
    
}
