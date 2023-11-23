//
//  DetailViewController.swift
//  SuperJunior
//
//  Created by 凱聿蔡凱聿 on 2023/10/20.
//

import UIKit

class DetailViewController: UIViewController {
    var image: UIImage?
    var imageName: String?
    
    @IBOutlet weak var imageView: UIImageView!

    init?(coder: NSCoder, image: UIImage, imageName: String) {
        self.image = image
        self.imageName = imageName
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // 初始化属性
        image = UIImage() // 默认图像
        imageName = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFit

        if let image = image {
            imageView.image = image
        } else if let imageName = imageName, let image = UIImage(named: imageName) {
            imageView.image = image
        } else {
            print("Image not found")
        }
    }
}
