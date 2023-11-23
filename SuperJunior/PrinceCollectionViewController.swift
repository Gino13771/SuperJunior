//
//  PrinceCollectionViewController.swift
//  SuperJunior
//
//  Created by 凱聿蔡凱聿 on 2023/10/20.
//

import UIKit


class PrinceCollectionViewController: UICollectionViewController {
    
    var superArray: [Super] = []
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           // 在這裡初始化 Super 陣列
           for i in 1...28 {
               let sjItem = Super(name: "SuperJunior", image: "p\(i)")
               superArray.append(sjItem)
           }
           
           configureCellSize()
       }
       
       override func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
       
       override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return superArray.count
       }
       
       override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrinceCollectionViewCell.reuseIdentifier, for: indexPath) as! PrinceCollectionViewCell
           let prince = superArray[indexPath.item]
           cell.imageView.image = UIImage(named: prince.image)
           
           return cell
       }
       
       override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let selectedPrince = superArray[indexPath.item]
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
               detailVC.imageName = selectedPrince.image
               detailVC.image = UIImage(named: selectedPrince.image)
               navigationController?.pushViewController(detailVC, animated: true)
           }
       }

       func configureCellSize() {
           let itemSpace: CGFloat = 4
           let columnCount: CGFloat = 3
           if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
               let width = floor((collectionView.bounds.width - itemSpace * (columnCount - 1)) / columnCount)
               flowLayout.itemSize = CGSize(width: width, height: width)
               flowLayout.estimatedItemSize = .zero
               flowLayout.minimumInteritemSpacing = itemSpace
               flowLayout.minimumLineSpacing = itemSpace
           }
       }
   }
