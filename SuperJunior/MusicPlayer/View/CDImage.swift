//
//  CDImage.swift
//  SuperJunior
//
//  Created by 凱聿蔡凱聿 on 2023/10/19.
//

import UIKit

class CDImage: UIImageView {
    
    /// 圓圈進度條
    func rotate(){
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = CGFloat.pi*2
        animation.duration = 5
        animation.repeatCount = .greatestFiniteMagnitude
        layer.add(animation, forKey: nil)
    }
}
    
