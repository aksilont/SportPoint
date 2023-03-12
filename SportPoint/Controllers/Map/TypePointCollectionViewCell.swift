//
//  TypePointCollectionViewCell.swift
//  SportPoint
//
//  Created by Aksilont on 08.03.2023.
//

import UIKit

final class TypePointCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        contentView.corneredRadius(radius: 15)
        contentView.layer.cornerCurve = .continuous
    }
    
    func configure(title: String) {
        typeLabel.text = title
    }
    
}
