//
//  PrinceCollectionViewCell.swift
//  SuperJunior
//
//  Created by 凱聿蔡凱聿 on 2023/10/20.
//

import UIKit

class PrinceCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "\(PrinceCollectionViewCell.self)"
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    static let width = floor((UIScreen.main.bounds.width - 4 * 2) / 3)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageWidthConstraint?.constant = Self.width
    }
}
