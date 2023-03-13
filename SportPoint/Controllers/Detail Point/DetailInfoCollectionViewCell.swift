//
//  DetailInfoCollectionViewCell.swift
//  SportPoint
//
//  Created by Aksilont on 13.03.2023.
//

import UIKit

class DetailInfoCollectionViewCell: UICollectionViewCell {
    
    lazy private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
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
        imageView.image = nil
    }
    
    // MARK: - UI
    
    private func setupView() {
        imageView.frame = contentView.frame
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.addSubview(imageView)
        
        contentView.corneredRadius(radius: 15)
        contentView.layer.cornerCurve = .continuous
    }
    
    // MARK: - Methods
    
    func configure(imageString: String) {
        if let image = UIImage(named: imageString) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "xmark.square")?
                .withTintColor(.systemGray3, renderingMode: .alwaysOriginal)
            return
        }
    }
    
}
