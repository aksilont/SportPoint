//
//  TypePointCollectionViewCell.swift
//  SportPoint
//
//  Created by Aksilont on 08.03.2023.
//

import UIKit

final class TypePointCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var typeLabel: UILabel!
    
    // MARK: - Properties
    
    private var activate: Bool = false {
        didSet {
            if activate {
                contentView.backgroundColor = UIColor(named: "TitleOnWhiteButton")
                typeLabel.textColor = .white
            } else {
                contentView.backgroundColor = .white
                typeLabel.textColor = .systemGray
            }
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Lyfe Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = .white
        typeLabel.tintColor = .systemGray
    }
    
    // MARK: - UI
    
    private func setupView() {
        contentView.corneredRadius(radius: 15)
        contentView.layer.cornerCurve = .continuous
    }
    
    // MARK: - Methods
    
    func configure(title: String) {
        typeLabel.text = title
    }
    
    func switchActive() -> Bool {
        activate = activate ? false : true
        return activate
    }
    
    func switchOff() {
        activate = false
    }

}
